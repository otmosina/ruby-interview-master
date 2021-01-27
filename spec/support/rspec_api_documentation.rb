# frozen_string_literal: true

require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.api_name = 'BAM API Documentation'
  config.format = :api_blueprint
  config.request_headers_to_include = ['Authorization', 'Content-Type', 'X-Refresh-Token']
  config.response_headers_to_include = ['Content-Type', 'Set-Cookie']
  config.request_body_formatter = :json
end
