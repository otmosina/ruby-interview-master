# frozen_string_literal: true

JSONAPI::Rails.configure do |config|
  # # Set a default serializable class mapping.
  # config.jsonapi_class = Hash.new { |h, k|
  #   names = k.to_s.split('::')
  #   klass = names.pop
  #   h[k] = [*names, "Serializable#{klass}"].join('::').safe_constantize
  # }
  #
  config.jsonapi_errors_class = Hash.new do |h, k|
    names = k.to_s.split('::')
    klass = names.pop
    h[k] = [*names, "Serializable#{klass}"].join('::').safe_constantize
  end

  config.jsonapi_errors_class.tap do |h|
    h[:'ActiveRecord::RecordNotFound'] = JSONAPI::Rails::StandardErrorsSerializer
    h[:'ActiveRecord::RecordNotUnique'] = JSONAPI::Rails::StandardErrorsSerializer
    h[:'ActiveRecord::InvalidForeignKey'] = JSONAPI::Rails::StandardErrorsSerializer
    h[:'Dry::Validation::Result'] = JSONAPI::Rails::DryValidationErrorsSerializer
    h[:'JSONAPI::Parser::InvalidDocument'] = JSONAPI::Rails::StandardErrorsSerializer
    h[:Hash] = JSONAPI::Rails::HashErrorsSerializer
    h[:String] = JSONAPI::Rails::StringErrorsSerializer
  end

  # # Set a default JSON API object.
  # config.jsonapi_object = {
  #   version: '1.0'
  # }
  #
  # # Set default cache.
  # # A lambda/proc that will be eval'd in the controller context.
  # config.jsonapi_cache = ->() { nil }
  #
  # # Uncomment the following to enable fragment caching. Make sure you
  # #   invalidate cache keys accordingly.
  # config.jsonapi_cache = lambda {
  #   Rails.cache
  # }
  #
  # # Set default exposures.
  # # A lambda/proc that will be eval'd in the controller context.
  # config.jsonapi_expose = lambda {
  #   { url_helpers: ::Rails.application.routes.url_helpers }
  # }
  #
  config.jsonapi_expose = lambda do
    {
      url_helpers: ::Rails.application.routes.url_helpers,
      current_user: current_user
    }
  end

  # # Set default fields.
  # # A lambda/proc that will be eval'd in the controller context.
  # config.jsonapi_fields = ->() { nil }
  #
  # # Uncomment the following to have it default to the `fields` query
  # #   parameter.
  # config.jsonapi_fields = lambda {
  #   fields_param = params.to_unsafe_hash.fetch(:fields, {})
  #   Hash[fields_param.map { |k, v| [k.to_sym, v.split(',').map!(&:to_sym)] }]
  # }
  #
  # # Set default include.
  # # A lambda/proc that will be eval'd in the controller context.
  # config.jsonapi_include = ->() { nil }
  #
  # # Uncomment the following to have it default to the `include` query
  # #   parameter.
  config.jsonapi_include = lambda do
    params.key?(:_jsonapi) ? params.dig(:_jsonapi, :include) : params[:include]
  end
  #
  # # Set default links.
  # # A lambda/proc that will be eval'd in the controller context.
  # config.jsonapi_links = ->() { {} }
  #
  # # Set default meta.
  # # A lambda/proc that will be eval'd in the controller context.
  # config.jsonapi_meta = ->() { nil }
  #
  # # Set a default pagination scheme.
  # config.jsonapi_pagination = ->(_) { {} }
  #
  # # Set a logger.
  # config.logger = Logger.new(STDOUT)
  #
  # # Uncomment the following to disable logging.
  config.logger = Logger.new('/dev/null')
end
