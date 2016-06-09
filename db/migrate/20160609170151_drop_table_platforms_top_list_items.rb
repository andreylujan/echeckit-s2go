class DropTablePlatformsTopListItems < ActiveRecord::Migration
  def change
  	drop_table :platforms_top_list_items
  end
end
