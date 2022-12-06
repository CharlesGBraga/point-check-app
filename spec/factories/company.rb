# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    cnpj { Faker::CNPJ.numeric }
    created_at { '2022 04:30:54' }
    updated_at { '2022 04:30:54' }
  end
end
