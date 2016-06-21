# -*- encoding : utf-8 -*-
class AddPublisherToProducts < ActiveRecord::Migration
  def change
    add_column :products, :publisher, :text
  end
end
