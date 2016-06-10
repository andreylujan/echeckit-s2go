# -*- encoding : utf-8 -*-
class RenameTableInboxActions < ActiveRecord::Migration
  def change
  	rename_table :inbox_actions, :message_actions
  end
end
