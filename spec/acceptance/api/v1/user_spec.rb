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

            example 'Responds with 401 after expire refresh token' do
              do_request
              Timecop.travel(Time.now + (ENV.fetch('REFRESH_EXP_DAYS').to_i + 1).days)
              do_request
              expect(status).to eq(401)
            end
          end
        end
      end
    end
  end
end
