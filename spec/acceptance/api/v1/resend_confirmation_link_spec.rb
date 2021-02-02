# frozen_string_literal: true

RSpec.describe 'Users' do
  resource 'API' do
    route '/api/v1/users/resend_confirmation_link{?include}', 'Users endpoint' do
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

        context 'try', :auth do 
          let(:authenticated_user) { create(:user) }
          before do
            create(:email_credential, user: authenticated_user)
          end

          example_request 'Responds with 200' do
            expect(status).to eq(201)
          end

        end     
       
        context 'try', :auth do 
          #let(:authenticated_user) { create(:user) }
          before do
            create(:email_credential, user: authenticated_user)
          end

          example 'Sent Time Has Changed' do
            do_request
            expect(authenticated_user.email_credential.reload.confirmation_sent_at).to_not be_nil
            #expect { do_request }.to( change {authenticated_user.email_credential.confirmation_sent_at}.from(nil).to(DateTime) )     
          end

          example 'Deliveres count has change' do
              expect { do_request }.to change { ActionMailer::Base.deliveries.count }.by(1)
          end

          example 'State Has Changed' do
            do_request
            expect(authenticated_user.email_credential.reload.state).to eq('active')
            #expect { do_request }.to( change {authenticated_user.email_credential.confirmation_sent_at}.from(nil).to(DateTime) )     
          end          
          
          
        end     
               
        
      end
    end
  end
end
  