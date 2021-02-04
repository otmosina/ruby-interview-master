# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'API' do
    route '/api/v1/users/confirmation_email{?include}', 'Users endpoint' do
      get 'Send Confirmation Link' do
        parameter :include, example: 'emailCredential'
        parameter :type, scope: :data, required: true

        with_options scope: %i[data attributes] do
          parameter :token, required: true
          parameter :original_token, required: true
        end

        let(:include) { 'emailCredential' }
        let(:type) { 'users' }

        
        #let(:email) { FFaker::Internet.email }
        #let(:password) { FFaker::Internet.password }
        let(:token) { "TOKEN" }
        let(:original_token) { "TOKEN" }

        context 'try match token', :auth do 
          let(:authenticated_user) { create(:user) }
          before do
            create(:email_credential, :pending, user: authenticated_user)
          end

          example_request 'Responds with 200' do
            expect(status).to eq(201)
          end

          example_request 'Change state of credential' do
            expect(status).to eq(201)
          end          
        end     

        context 'try not match token', :auth do 
          let(:original_token) { "TOKEN2" }
          let(:authenticated_user) { create(:user) }
          before do
            create(:email_credential, :pending, user: authenticated_user)
          end

          example_request 'Responds with 4**' do
            expect(status).to eq(422)
          end
        end             
        
      end
    end
  end
end
  