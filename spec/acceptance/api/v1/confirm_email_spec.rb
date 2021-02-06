# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'API' do
    route '/api/v1/users/confirm_email{?include}', 'Users endpoint' do
      get 'Send Confirmation Link' do
        parameter :include, example: 'emailCredential'
        parameter :type, scope: :data, required: true

        with_options scope: %i[data attributes] do
          parameter :token, required: true
        end

        let(:include) { 'emailCredential' }
        let(:type) { 'users' }
        let(:token) { FFaker::String.rand }

        context 'when confirmatio token is correct', :auth do 
          let(:authenticated_user) { create(:user) }
          let(:token) { authenticated_user.token }
          before do
            create(:email_credential, :pending, user: authenticated_user)
            create(:confirmation_request, email: authenticated_user.email_credential.email, confirmation_sent_at: Time.now - (ConfirmationRequest::CONFIRMATION_REQUEST_TTL_MINUTES + 1).minutes)
          end

          example_request 'Responds with 200' do
            expect(status).to eq(201)
          end

          example_request 'Change state of credential to active' do
            expect(authenticated_user.email_credential.reload.active?).to eq(true)
          end 
          
          example_request 'Set confirmation at in entity' do
            expect(authenticated_user.email_credential.reload.confirmed_at).to_not be_nil
          end           
        end     

        context 'when confirmation token is incorrect', :auth do 
          let(:authenticated_user) { create(:user) }
          before do
            create(:email_credential, :pending, user: authenticated_user)
            create(:confirmation_request, email: authenticated_user.email_credential.email, confirmation_sent_at: Time.now - (ConfirmationRequest::CONFIRMATION_REQUEST_TTL_MINUTES + 1).minutes)
          end

          example_request 'Responds with 4**' do
            expect(status).to eq(422)
            expect(parsed_body['errors']).to contain_exactly(
              '' => ['Tokens not matched']
            )            
          end

          example_request 'Change state of credential to active' do
            expect(authenticated_user.email_credential.reload.pending?).to eq(true)
          end 
          
          example_request 'Set confirmation at in entity' do
            expect(authenticated_user.email_credential.reload.confirmed_at).to be_nil
          end            
        end             
        
      end
    end
  end
end
  