class CreatePoints < ActiveRecord::Migration[7.0]
  def change
    create_table :points do |t|
      t.datetime :marking
      t.string :marking_type
      t.boolean :approved, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
