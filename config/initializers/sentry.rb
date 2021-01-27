# frozen_string_literal: true

if Rails.env.production? || Rails.env.staging?
  Raven.configure do |config|
    config.dsn = ENV.fetch('SENTRY_DSN')
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)

    config.open_timeout = 3
    config.timeout = 3
  end
end
