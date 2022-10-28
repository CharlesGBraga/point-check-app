# frozen_string_literal: true

User.delete_all

2.times do |i|
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    cpf: "1234567891#{i}",
    password_digest: BCrypt::Password.create('teste'),
    admin: true
  )
end
