class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.text :name, null: false
      t.references :dealer, foreign_key: true, null: false
      t.timestamps
    end
    add_index :stores, [:dealer_id, :name], unique: true
  end
end
