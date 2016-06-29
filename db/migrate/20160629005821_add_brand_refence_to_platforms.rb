class AddBrandRefenceToPlatforms < ActiveRecord::Migration
  def change
    add_reference :platforms, :brand, index: true, foreign_key: true
  end
end
