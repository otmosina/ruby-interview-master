# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'API' do
    route '/api/v1/users/resend_confirmation_link{?include}', 'Users endpoint' do
      get 'Resend Confirmation Link' do
        parameter :include, example: 'emailCredential'
        parameter :type, scope: :data, required: true

        with_options scope: %i[data attributes] do
          parameter :email, required: true
        end

        let(:email) { "testemail@example.com" } # { FFaker::Internet.email }
        let(:include) { 'emailCredential' }
        let(:type) { 'users' }

        context 'When no email credential -> no connfirmation requests before' do
          example_request 'Respond with 422' do
            expect(status).to eq(422)
          end
        end

        context 'When user authenticated', :auth do
          let(:email_credential) { create(:email_credential, user: authenticated_user) }
          let(:email) { email_credential.email }

          before do
            create(:confirmation_request, email: email, confirmation_sent_at: Time.now - (ConfirmationRequest::CONFIRMATION_REQUEST_TTL_MINUTES + 1).minutes)
          end

          example_request 'Responds with 201 request is valid' do
            expect(status).to eq(201)
          end

          example_request 'Send time attribute has changed' do
            expect(ConfirmationRequest.last.confirmation_sent_at).not_to be_nil
          end

          example 'Mail deliveres count has change' do
            expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(1)
          end

          example_request 'Confirmation request state has not changed' do
            expect(ConfirmationRequest.where(email: email).last.state).to eq('pending')
            # expect(authenticated_user.email_credential.reload.state).to eq('pending')
          end

          example_request 'We are sent 2 requests already' do
            expect(ConfirmationRequest.where(email: email).size).to eq(2)
          end

          example 'Responds with 422 when try to send cofirmation link 2 times in a row' do
            do_request
            do_request
            expect(status).to eq(422)
            expect(parsed_body['errors']).to contain_exactly(
              '' => ['Too Much Requests']
            )
          end

          example 'Responds with 422 when try to send cofirmation link 2 times in short time period' do
            do_request
            Timecop.travel(Time.now + (ConfirmationRequest::CONFIRMATION_REQUEST_TTL_MINUTES - 1).minutes)
            do_request
            expect(status).to eq(422)
          end

          example 'Responds with 422 when try to send cofirmation link 2 times in valid time period' do
            do_request
            Timecop.travel(Time.now + (ConfirmationRequest::CONFIRMATION_REQUEST_TTL_MINUTES + 1).minutes)
            do_request
            expect(status).to eq(201)
          end
        end
      end
    end
  end
end
