# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'testes' }
    cpf { Faker::CPF.numeric }
    created_at { '2022 04:30:54' }
    updated_at { '2022 04:30:54' }
    admin { [true, false].sample }

    trait :unique_items do
      sequence(:name) { |n| "#{Faker::Name.name} #{n + 1}" }
    end
  end
end
