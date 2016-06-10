# -*- encoding : utf-8 -*-
class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :title
      t.text :html
      t.integer :sender_id
      t.references :message_action, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :messages, :sender_id
  end
end
