# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'API' do
    route '/api/v1/users/send_confirmation_link{?include}', 'Users endpoint' do
      get 'Send Confirmation Link' do
        parameter :include, example: 'emailCredential'
        parameter :type, scope: :data, required: true

        let(:include) { 'emailCredential' }
        let(:type) { 'users' }

        context 'when user is not authenticated' do
          example_request 'Responds with 401' do
            expect(status).to eq(401)
          end
          example 'Deliveres count has not changed' do
            expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(0)
          end 
        end        

        context 'when user authenticated', :auth do 
          let(:authenticated_user) { create(:user) }
          before do
            create(:email_credential, :pending, user: authenticated_user)
          end

          example_request 'Responds with 200' do
            expect(status).to eq(201)
          end
          
          example 'Sent time has changed' do
            do_request
            expect(authenticated_user.email_credential.reload.confirmation_sent_at).to_not be_nil 
          end

          example 'Sent time has NOT changed(errors from Emailer)' do
            allow_any_instance_of(Users::EmailService).to receive(:call).and_raise(Net::SMTPServerBusy)
            do_request
            expect(authenticated_user.email_credential.reload.confirmation_sent_at).to be_nil 
          end          

          example 'Deliveres count has change' do
            expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(1)
          end

          example 'State has not changed' do
            do_request
            expect(authenticated_user.email_credential.reload.state).to eq('pending')    
          end              
        end      
      end
    end
  end
end
  