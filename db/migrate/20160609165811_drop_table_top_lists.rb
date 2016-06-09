class DropTableTopLists < ActiveRecord::Migration
  def change
  	drop_table :top_list_items
  	drop_table :top_lists
  end
end
