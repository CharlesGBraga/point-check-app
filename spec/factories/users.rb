FactoryBot.define do
  factory :user do
    password_digest { "MyString" }
    email { "MyString" }
  end
end
