# frozen_string_literal: true

User.delete_all
Company.delete_all 
FactoryBot.create_list(:user, 10, :unique_items)