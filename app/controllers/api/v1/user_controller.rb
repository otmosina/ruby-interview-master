# frozen_string_literal: true

module Api::V1
  class UserController < ::Api::V1::ApplicationController
    def show
      responds_with_resource(current_user)
    end
  end
end
