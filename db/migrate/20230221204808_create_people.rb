class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :usage_name, null: false, default: ''
      t.string :first_name, null: false
      t.string :middle_name, null: false, default: ''
      t.string :last_name, null: false
      t.string :email, null: false, default: ''
      t.string :phone, null: false, default: ''

      t.timestamps
    end
  end
end
