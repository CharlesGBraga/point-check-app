# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    cpf { Faker::CPF.numeric }
    created_at { '2022 04:30:54' }
    updated_at { '2022 04:30:54' }
    admin { true }
  end
end
