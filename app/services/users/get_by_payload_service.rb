# frozen_string_literal: true

module Users
  class GetByPayloadService
    def call(payload)
      user = User.active.find_by(id: payload.fetch('sub'))

      raise JWTSessions::Errors::Error if user.nil?

      user
    end
  end
end
