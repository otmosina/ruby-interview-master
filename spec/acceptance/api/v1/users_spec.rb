# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'Auth' do
    route '/api/v1/users{?include}', 'Users endpoint' do
      post 'Create user' do
        parameter :include, example: 'emailCredential'
        parameter :type, scope: :data, required: true

        with_options scope: %i[data attributes] do
          parameter :email, required: true
          parameter :password, required: true
        end

        let(:include) { 'emailCredential' }
        let(:type) { 'users' }
        let(:email) { FFaker::Internet.email }
        let(:password) { FFaker::Internet.password }

        example 'Responds with 201 when params are valid', :aggregate_failures do
          expect { do_request }.to(
            change { User.count }.by(1)
              .and(change { EmailCredential.count }.by(1))
                .and(change {ConfirmationRequest.count}.by(1))
          )

          expect(status).to eq(201)
        end

        example_request 'Set send time of confirmation mail' do
          expect(ConfirmationRequest.last.confirmation_sent_at).to_not be_nil
        end  
        
        example 'Deliveres count has change' do
          expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end

        #TODO: test how to deliver to sidekiq queue
        #example 'Send email to sidekiq' do 
        #  expect do 
        #    do_request
        #  end.to change( Sidekiq::Worker.jobs, :size ).by(1)
        #end

        context 'when errors in sending mail' do
          example 'Sent mails count & sent_at have not changed' do
            allow_any_instance_of(ActionMailer::MessageDelivery).to receive(:deliver_now).and_raise(Net::SMTPServerBusy)
            do_request
            expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(0)
            #expect(User.last.email_credential.reload.confirmation_sent_at).to be_nil 
            expect(ConfirmationRequest.all.size).to eq(0) 
          end  
        end       

        context 'when params are invalid' do
          let(:password) { nil }

          example_request 'Responds with 422 when params are invalid' do
            expect(status).to eq(422)
            expect(parsed_body['errors']).to contain_exactly(
              'password' => ['must be filled']
            )
          end
          example 'Deliveres count has not changed' do
            expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(0)
          end        
        end

        context 'when email credential already exists' do
          let(:user2) { create(:user) }
          let!(:email_credential) { create(:email_credential, email: email, user: user2) }

          example 'Responds with 409 when email credential already exists' do
            do_request

            expect(status).to eq(409)
          end
        end
      end
    end
  end
end
