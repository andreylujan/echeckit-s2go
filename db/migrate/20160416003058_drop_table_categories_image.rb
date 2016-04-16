class DropTableCategoriesImage < ActiveRecord::Migration
  def change
  	drop_table :categories_images
  	add_reference :images, :category, index: true, foreign_key: true
  end
end
