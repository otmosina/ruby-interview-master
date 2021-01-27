# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Pg is the Ruby interface to the {PostgreSQL RDBMS}
gem 'pg', '~> 1.1', '>= 1.1.4'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 1.0', '>= 1.0.3'
# A simple validation library
gem 'dry-validation', '~> 1.6'
# Common monads for Ruby.
gem 'dry-monads', '~> 1.3', '>= 1.3.5'
# A simple container intended for use as an IoC container
gem 'dry-container', '~> 0.7.2'
# Container-agnostic automatic constructor injection
gem 'dry-auto_inject', '~> 0.7.0'
# Typed structs and value objects.
gem 'dry-struct', '~> 1.4'
# XSS/CSRF safe JWT auth designed for SPA
gem 'jwt_sessions', '~> 2.3', '>= 2.3.1'
# A Ruby client that tries to match Redis' API one-to-one, while still providing an idiomatic interface.
gem 'redis', '~> 4.1'
# Efficient, convenient, non-intrusive JSONAPI framework for Rails.
gem 'jsonapi-rails', '~> 0.4.0'
# Validate JSONAPI response documents, resource creation/update payloads, and relationship update payloads.
gem 'jsonapi-parser', '~> 0.1.1'
# Define native database types and change default migration behavior in ActiveRecord/Rails.
gem 'activerecord-native_db_types_override', '~> 0.3.0'
# Simple, efficient background processing for Ruby.
gem 'sidekiq', '~> 5.2', '>= 5.2.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug', '~> 3.7'
  # Use Pry as your rails console
  gem 'pry-rails', '~> 0.3.9'
  # Autoload dotenv in Rails.
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.2'
  # rspec-rails is a testing framework for Rails 3+.
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  # Ffaker generates dummy data.
  gem 'ffaker', '~> 2.11'
  # factory_bot_rails provides integration between factory_bot and rails 4.2 or newer
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
  # Automatic Ruby code style checking tool.
  gem 'rubocop', '~> 0.67.2'
  # A collection of RuboCop cops to check for performance optimizations in Ruby code.
  gem 'rubocop-performance', '~> 1.1'
  # Code style checking for RSpec files. A plugin for the RuboCop code style enforcing & linting tool.
  gem 'rubocop-rspec', '~> 1.32'
  # Great Ruby dubugging companion: pretty print Ruby objects to visualize their structure.
  gem 'awesome_print', '~> 1.8'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Strategies for cleaning databases. Can be used to ensure a clean state for testing.
  gem 'database_cleaner', '~> 1.7'
  # A gem providing "time travel" and "time freezing" capabilities.
  gem 'timecop', '~> 0.9.1'
  # Generate API docs from your test suite
  gem 'rspec_api_documentation', '~> 6.1', github: 'zipmark/rspec_api_documentation', ref: '54fbfda'
  # Validate your Rails JSON API's JSON
  gem 'json_matchers', '~> 0.10.0'
  # WebMock allows stubbing HTTP requests and setting expectations on HTTP requests.
  gem 'webmock', '~> 3.6'
  # Record test HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.
  gem 'vcr', '~> 5.0'
  # Helpers for validating JSON API payloads
  gem 'jsonapi-rspec', '~> 0.0.11'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
