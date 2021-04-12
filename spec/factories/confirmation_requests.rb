# frozen_string_literal: true

FactoryBot.define do
  factory :confirmation_request do
    email { FFaker::Internet.unique.email }
    confirmation_sent_at { DateTime.now }
    state { 'pending' }

    trait :pending do
      state { 'pending' }
    end

    trait :active do
      state { 'active' }
      confirmed_at { FFaker::Time.datetime }
    end

    trait :deleted do
      deleted_at { FFaker::Time.datetime }
    end    
  end
end
