# frozen_string_literal: true

require 'sidekiq/web'

mount Sidekiq::Web, at: '/sidekiq'
