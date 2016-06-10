# -*- encoding : utf-8 -*-
class RenameTableMessages < ActiveRecord::Migration
  def change
  	rename_table :messages, :broadcasts
  end
end
