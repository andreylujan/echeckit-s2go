class CreateDealers < ActiveRecord::Migration[5.0]
  def change
    create_table :dealers do |t|
      t.text :name, null: false
      t.references :zone, foreign_key: true, null: false

      t.timestamps
    end
    add_index :dealers, [:zone_id, :name], unique: true
  end
end
