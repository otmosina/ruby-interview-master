# frozen_string_literal: true

module Api::V1
  module Users
    class CreateAction < ::Api::V1::BaseAction
      def call(input)
        params = yield deserialize(input)
        params[:emailer] = @emailer.new
        params = yield validate(params)
        params[:emailer] = params[:emailer].class
        create(params)
      end

      private

      def create(input)
        Try(active_record_common_errors) do
          user = ::Users::CreateService.new.call(input)
          ::Users::SendConfirmationLinkService.new.call(input.merge!({user_id: user.id}))
          user
        end.to_result
      end
    end
  end
end
