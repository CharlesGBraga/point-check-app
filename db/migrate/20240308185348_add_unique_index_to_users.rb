class AddUniqueIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, [:cpf, :company_id], unique: true
    add_index :users, [:email, :company_id], unique: true
  end
end
