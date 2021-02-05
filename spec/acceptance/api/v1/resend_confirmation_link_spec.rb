# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'API' do
    route '/api/v1/users/resend_confirmation_link{?include}', 'Users endpoint' do
      get 'Resend Confirmation Link' do
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

          example_request 'Responds with 201 request is valid' do
            expect(status).to eq(201)
          end          

          example_request 'Send time attribute has changed' do
            expect(authenticated_user.email_credential.reload.confirmation_sent_at).to_not be_nil   
          end

          example 'Mail deliveres count has change' do
            expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(1)
          end

          example_request 'Email confirmation state has not changed' do
            expect(authenticated_user.email_credential.reload.state).to eq('pending')    
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
            Timecop.travel(Time.now + (EmailCredential::CONFIRMATION_REQUEST_TTL_MINUTES - 1).minutes)
            do_request
            expect(status).to eq(422)
          end

          example 'Responds with 422 when try to send cofirmation link 2 times in valid time period' do
            do_request
            Timecop.travel(Time.now + (EmailCredential::CONFIRMATION_REQUEST_TTL_MINUTES + 1).minutes)
            do_request
            expect(status).to eq(201)
          end          
        end     
      end
    end
  end
end
  