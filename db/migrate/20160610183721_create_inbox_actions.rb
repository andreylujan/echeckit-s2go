# -*- encoding : utf-8 -*-
class CreateInboxActions < ActiveRecord::Migration
  def change
    create_table :inbox_actions do |t|
      t.references :organization, index: true, foreign_key: true
      t.text :name, null: false
      t.timestamps null: false
    end
    add_index :inbox_actions, [ :organization_id, :name ], unique: true
  end
end
