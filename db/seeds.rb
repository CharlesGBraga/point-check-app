# frozen_string_literal: true

User.delete_all

2.times do
  FactoryBot.create(:user)
end
