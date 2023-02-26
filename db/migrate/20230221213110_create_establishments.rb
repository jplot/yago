class CreateEstablishments < ActiveRecord::Migration[7.0]
  def change
    create_table :establishments do |t|
      t.references :company, null: false, foreign_key: true

      t.boolean :primary, null: false, default: false
      t.string :name
      t.string :number, null: false
      t.date :activity_begins_at, null: false
      t.date :activity_ends_at

      t.timestamps
    end
  end
end
