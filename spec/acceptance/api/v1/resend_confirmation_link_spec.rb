# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'API' do
    route '/api/v1/users/resend_confirmation_link{?include}', 'Users endpoint' do
      get 'Send Confirmation Link' do
        parameter :include, example: 'emailCredential'
        parameter :type, scope: :data, required: true

        let(:include) { 'emailCredential' }
        let(:type) { 'users' }

        context 'When user not authenticated' do
          example_request 'Respond with 401' do
            expect(status).to eq(401)
          end
        end

        context 'When user authenticated', :auth do 
          before do
            create(:email_credential, :pending, user: authenticated_user)
          end

          example_request 'Responds with 200' do
            expect(status).to eq(201)
          end          

          example 'Sent Time Has Changed' do
            do_request
            expect(authenticated_user.email_credential.reload.confirmation_sent_at).to_not be_nil   
          end

          example 'Deliveres count has change' do
              expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(1)
          end

          example 'State Has Changed' do
            do_request
            expect(authenticated_user.email_credential.reload.state).to eq('pending')    
          end   
          
          context 'when too much requests' do
            example 'Responds with 201 when try to send cofirmation link' do
              do_request
              expect(status).to eq(201)
            end 

            example 'Responds with 422 when try to send cofirmation link too often coz request still is not valid' do
              do_request
              Timecop.travel(Time.now + (EmailCredential::CONFIRMATION_REQUEST_TTL_MINUTES - 1).minutes)
              do_request
              expect(status).to eq(422)
            end            

            example 'Responds with 201 when try to send cofirmation link too often coz request is valid' do
              do_request
              Timecop.travel(Time.now + (EmailCredential::CONFIRMATION_REQUEST_TTL_MINUTES + 1).minutes)
              do_request
              expect(status).to eq(201)
            end
            
            example 'Responds with 422 when try to send cofirmation link too often' do
              do_request
              do_request
              expect(status).to eq(422)
              expect(parsed_body['errors']).to contain_exactly(
                '' => ['Too Much Requests']
              )
            end
          end   
        end     
      end
    end
  end
end
  