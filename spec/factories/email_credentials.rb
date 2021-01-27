# frozen_string_literal: true

FactoryBot.define do
  factory :email_credential do
    email { FFaker::Internet.unique.email }
    password { FFaker::Internet.password }
    password_confirmation { password }
    state { 'active' }
    user

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
