# frozen_string_literal: true

RSpec.describe ::Api::V1::UserSerializer, type: :serializer do
  subject(:result) { serialize_entity(user, class: {User: described_class}) }

  let(:user) { build_stubbed(:user) }

  describe 'type' do
    it 'returns proper type' do
      expect(result.dig(:data, :type)).to eq :users
    end
  end

  describe 'relationships' do
    context 'when current user' do
      subject(:result) { serialize_entity(user, class: {User: described_class}, expose: {current_user: user}) }

      it 'returns proper relationships' do
        expect(result.dig(:data, :relationships).keys).to match_array(
          %i[
            profile
            emailCredential
          ]
        )
      end
    end

    context 'when not current user' do
      subject(:result) { serialize_entity(user, class: {User: described_class}) }

      it 'returns proper relationships' do
        expect(result.dig(:data, :relationships).keys).to match_array(
          %i[
            profile
          ]
        )
      end
    end
  end
end
