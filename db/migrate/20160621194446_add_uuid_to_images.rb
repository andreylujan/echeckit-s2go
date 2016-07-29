# -*- encoding : utf-8 -*-
class AddUuidToImages < ActiveRecord::Migration
  def change
    add_column :images, :uuid, :text
  end
end
