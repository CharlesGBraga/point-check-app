# frozen_string_literal: true

User.delete_all

4.times do
  FactoryBot.create(:user)
end
