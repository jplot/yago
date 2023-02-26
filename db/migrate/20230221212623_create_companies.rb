class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :kind, null: false
      t.string :name, null: false
      t.string :number, null: false
      t.boolean :natural_person, null: false
      t.integer :annual_revenue, null: false, default: 0
      t.date :activity_begins_at, null: false
      t.date :activity_ends_at

      t.timestamps
    end
  end
end
