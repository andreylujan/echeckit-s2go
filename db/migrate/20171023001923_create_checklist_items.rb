class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.text :name, null: false
      t.boolean :required, null: false, default: false
      t.integer :position
      t.jsonb :data, null: false, default: {}
      t.integer :checklist_id

      t.timestamps null: false
    end
    create_table :checklists do |t|
      t.text :name, null: false
      t.integer :position
      t.text :icon
      t.boolean :required, null: false, default: false

      t.timestamps null: false
    end
    add_index :checklist_items, :checklist_id
    DataPart::inheritance_column = nil
    DataPart.where(type: "ChecklistItem").each do |data_part|
      ChecklistItem.create! id: data_part.id,
        name: data_part.name,
        required: data_part.required,
        position: data_part.position,
        data: data_part.data,
        checklist_id: data_part.parent.present? ? data_part.parent.id : nil
    end

    DataPart.where(type: "Checklist").each do |data_part|
      Checklist.create! id: data_part.id,
        name: data_part.name,
        required: data_part.required,
        position: data_part.position,
        icon: data_part.icon
    end

    DataPart::inheritance_column = "type"
    ActiveRecord::Base.connection.execute("SELECT setval('checklist_items_id_seq', COALESCE((SELECT MAX(id)+1 FROM data_parts), 1), false);")
    ActiveRecord::Base.connection.execute("SELECT setval('checklists_id_seq', COALESCE((SELECT MAX(id)+1 FROM data_parts), 1), false);")
  end
end
