# frozen_string_literal: true

FactoryBot.define do
  factory :point do
    marking { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    marking_type { %w[start_work going_lunch return_lunch end_work].sample }
    approved { true }
    user { create(:user) }

    trait :unique_items do
      sequence(:marking) { |n| "#{Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)} #{n + 1}" }
    end
  end
end
