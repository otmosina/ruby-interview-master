# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = {size: 5, url: ENV.fetch('SIDEKIQ_REDIS_URL')}

  Sidekiq::Cron::Job.load_from_hash(YAML.load_file('config/schedule.yml'))
end

Sidekiq.configure_client do |config|
  config.redis = {size: 1, url: ENV.fetch('SIDEKIQ_REDIS_URL')}
end
