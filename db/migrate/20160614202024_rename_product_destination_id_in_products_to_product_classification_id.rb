# -*- encoding : utf-8 -*-
class RenameProductDestinationIdInProductsToProductClassificationId < ActiveRecord::Migration
  def change
  	rename_column :products, :product_destination_id, :product_classification_id
  end
end
