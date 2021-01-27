# frozen_string_literal: true

RSpec.shared_context 'with authenticated user' do
  let(:authenticated_user) { create(:user) }

  before do
    session = JWTSessions::Session.new(payload: {sub: authenticated_user.id})
    token = session.login.fetch(:access)

    header "Authorization", "Bearer #{token}"
  end
end
