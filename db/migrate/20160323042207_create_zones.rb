class CreateZones < ActiveRecord::Migration[5.0]
  def change
    create_table :zones do |t|
      t.text :name, null: false

      t.timestamps
    end
    add_index :zones, :name, unique: true
  end
end
