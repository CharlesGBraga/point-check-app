# frozen_string_literal: true

class RemoveProfileFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :profile, :boolean
    add_column :users, :admin, :boolean, default: false
  end
end
