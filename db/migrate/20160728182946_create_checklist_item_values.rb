class CreateChecklistItemValues < ActiveRecord::Migration
  def change
    create_table :checklist_item_values do |t|
      t.references :report, index: true, foreign_key: true, null: false
      t.boolean :item_value, null: false

      t.timestamps null: false
    end
  end
end
