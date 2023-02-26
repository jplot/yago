class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :record, polymorphic: true, null: false
      t.string :code

      t.timestamps
    end
  end
end
