# -*- encoding : utf-8 -*-
class RenameUrlInImagesToImage < ActiveRecord::Migration
  def change
  	rename_column :images, :url, :image
  end
end
