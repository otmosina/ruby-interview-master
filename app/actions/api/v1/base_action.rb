# frozen_string_literal: true

module Api::V1
  class BaseAction
    include Dry::Monads[:result, :do, :try]
    include App::Import[
      deserializer: 'operations.params.deserialize'
    ]

    def initialize(context: {}, **args)
      @current_user = context.fetch(:current_user)

      super(args)
    end

    private

    attr_reader :current_user

    def active_record_common_errors
      [ActiveRecord::InvalidForeignKey, ActiveRecord::RecordNotUnique]
    end

    def deserialize(input)
      deserializer.call(input)
    end

    def validate(input)
      resolve_contract.new.call(input).to_monad.fmap(&:to_h)
    end

    def resolve_contract
      [
        self.class.name.deconstantize,
        self.class.name.demodulize.underscore.gsub("_action", "_contract").classify
      ].join("::").constantize
    end

    def authorized?(entity = nil)
      allowed?(entity)
    end

    def allowed?(entity = nil)
      policy_class = resolve_policy
      policy_method = resolve_policy_method

      policy_class.new(user: current_user, record: entity).send("#{policy_method}?")
    end

    def allowed_scope(default_scope)
      policy_class = resolve_policy

      policy_class::Scope.new(user: current_user, scope: default_scope).resolve
    end

    def resolve_policy
      namespace = self.class.name.deconstantize
      policy_namespace = namespace.deconstantize
      policy_name = "#{namespace.demodulize.singularize}Policy"

      [policy_namespace, policy_name].join("::").constantize
    end

    def resolve_policy_method
      self.class.name.demodulize.underscore.remove("_action")
    end
  end
end
