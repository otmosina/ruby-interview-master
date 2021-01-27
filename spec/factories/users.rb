# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    trait :deleted do
      deleted_at { 1.week.ago }
    end
  end
end
