class RenameTableProductDestinationsToProductClassifications < ActiveRecord::Migration
  def change
  	rename_table :product_destinations, :product_classifications
  end
end
