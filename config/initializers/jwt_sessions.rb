# frozen_string_literal: true

JWTSessions.tap do |config|
  config.encryption_key = ENV.fetch('JWT_SESSIONS_ENCRYPTION_KEY')
  config.token_store = :redis, {redis_url: ENV.fetch('JWT_SESSIONS_REDIS_URL')}
  config.access_exp_time = ENV.fetch('ACCESS_EXP_DAYS').to_i.days
  config.refresh_exp_time = ENV.fetch('REFRESH_EXP_DAYS').to_i.days
end
