# frozen_string_literal: true

FactoryBot.define do
  factory :confirmation_request do
    email { FFaker::Internet.unique.email }
    confirmation_sent_at { DateTime.now }
  end
end
