# -*- encoding : utf-8 -*-
class AddActionTextToBroadcasts < ActiveRecord::Migration
  def change
    add_column :broadcasts, :action_text, :text
  end
end
