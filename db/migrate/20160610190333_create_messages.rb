# -*- encoding : utf-8 -*-
class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :broadcast, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.boolean :read, null: false, default: false
      t.datetime :read_at
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :messages, :read
    add_index :messages, :deleted_at
  end
end
