# frozen_string_literal: true

FactoryBot.define do
  factory :email_credential do
    email { FFaker::Internet.unique.email }
    password { FFaker::Internet.password }
    password_confirmation { password }
    user
  end
end
