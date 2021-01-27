# frozen_string_literal: true

module Api::V1
  class UserSerializer < Api::V1::BaseSerializer
    has_one :profile
    has_one :email_credential, if: -> { current_user? }

    def current_user?
      @current_user&.id == @object.id
    end
  end
end
