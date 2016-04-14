class CreateTopLists < ActiveRecord::Migration
  def change
    create_table :top_lists do |t|
      t.references :organization, index: true, foreign_key: true, null: false
      t.text :name
      t.text :icon

      t.timestamps null: false
    end
  end
end
