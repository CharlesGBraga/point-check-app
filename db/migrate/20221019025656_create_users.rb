class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: { unique: true }
      t.string :cpf
      t.string :password_digest
      t.boolean :profile

      t.timestamps
    end
  end
end
