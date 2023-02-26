class CreateManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :managers do |t|
      t.references :person, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
