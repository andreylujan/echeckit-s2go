class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.text :name, null: false
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :product_types, [ :organization_id, :name ], unique: true
  end
end
