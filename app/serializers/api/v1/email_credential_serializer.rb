# frozen_string_literal: true

module Api::V1
  class EmailCredentialSerializer < Api::V1::BaseSerializer
    type 'emailCredentials'

    attributes :email,
               :state,
               :confirmed_at

    def current_user?
      @current_user&.id == @object.user_id
    end
  end
end
