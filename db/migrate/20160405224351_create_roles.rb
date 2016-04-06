class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :organization, index: true, foreign_key: true, null: false
      t.text :name, null: false

      t.timestamps
    end
    add_index :roles, [ :organization_id, :name ], unique: true
  end
end
