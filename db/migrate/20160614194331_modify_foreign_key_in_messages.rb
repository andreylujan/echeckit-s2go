# -*- encoding : utf-8 -*-
class ModifyForeignKeyInMessages < ActiveRecord::Migration
  def change
  	remove_foreign_key :messages, :broadcasts
  	add_foreign_key :messages, :broadcasts, on_delete: :cascade
  end
end
