class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :record, polymorphic: true, null: false
      t.string :address, null: false
      t.string :additional_info, null: false, default: ''
      t.string :zipcode, null: false, default: ''
      t.string :city, null: false
      t.string :country, null: false

      t.timestamps
    end
  end
end
