class CreateDataParts < ActiveRecord::Migration
  def change
    create_table :data_parts do |t|
      t.references :subsection, index: true, foreign_key: true
      t.text :type, null: false
      t.text :name, null: false
      t.text :icon
      t.boolean :required, null: false, default: true
      t.references :data_part, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
