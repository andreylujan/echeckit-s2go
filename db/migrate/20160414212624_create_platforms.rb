class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.text :name, null: false
      t.references :organization, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :platforms, [ :organization_id, :name ], unique: true
  end
end
