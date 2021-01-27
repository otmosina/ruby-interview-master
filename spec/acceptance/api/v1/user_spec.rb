# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'Current user endpoint' do
    route '/api/v1/user{?include}', 'Current user endpoint' do
      get 'Get current' do
        parameter :include, example: 'emailCredential'

        let(:include) { 'emailCredential' }

        context 'when user is not authenticated' do
          example_request 'Responds with 401' do
            expect(status).to eq(401)
          end
        end

        context 'when user is authenticated', :auth do
          context 'when user is deleted' do
            let(:authenticated_user) { create(:user, :deleted) }

            example_request 'Responds with 401' do
              expect(status).to eq(401)
            end
          end

          context 'when user is active' do
            before do
              create(:email_credential, user: authenticated_user)
            end

            example_request 'Responds with 200' do
              expect(status).to eq(200)
              expect(response_body).to match_response_schema('v1/user')
              expect(parsed_included).to contain_exactly(
                have_type('emailCredentials')
              )
            end
          end
        end
      end
    end
  end
end
