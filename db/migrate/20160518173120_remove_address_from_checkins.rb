# -*- encoding : utf-8 -*-
class RemoveAddressFromCheckins < ActiveRecord::Migration
  def change
    remove_column :checkins, :address, :text
  end
end
