# frozen_string_literal: true

User.delete_all
Company.delete_all
Point.delete_all 
# FactoryBot.create_list(:user, 10, :unique_items)
FactoryBot.create_list(:point, 10, :unique_items)