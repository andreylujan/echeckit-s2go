class CreateTopListItems < ActiveRecord::Migration
  def change
    create_table :top_list_items do |t|
      t.references :top_list, index: true, foreign_key: true
      t.text :name, null: false
      t.text :images, null: false, array: true, default: []

      t.timestamps null: false
    end

    add_index :top_list_items, [ :top_list_id, :name ], unique: true

    create_table :platforms_top_list_items, id: false do |t|
        t.references :platform, index: true
        t.references :top_list_item, index: true
    end    
  end
end
