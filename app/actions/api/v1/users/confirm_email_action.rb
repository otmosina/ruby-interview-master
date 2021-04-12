# frozen_string_literal: true

module Api::V1
  module Users
    class ConfirmEmailAction < ::Api::V1::BaseAction
      def call(input)
        params = yield deserialize(input)
        params = yield validate(params)
        create(params)
      end

      private

      def create(input)
        Try(active_record_common_errors) do
          ::Users::ConfirmEmailService.new.call(input)
        end.to_result
      end
    end
  end
  end
