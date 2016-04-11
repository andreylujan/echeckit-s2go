class CreateSubsectionItems < ActiveRecord::Migration
  def change
    create_table :subsection_items do |t|
      t.references :subsection_item_type, index: true, foreign_key: true, null: false
      t.references :subsection, index: true, foreign_key: true, null: false
      t.boolean :has_details, null: false
      t.text :name, null: false

      t.timestamps null: false
    end
    add_index :subsection_items, [ :subsection_id, :name ], unique: true
  end
end
