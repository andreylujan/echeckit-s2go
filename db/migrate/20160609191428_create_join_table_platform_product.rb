class CreateJoinTablePlatformProduct < ActiveRecord::Migration
  def change
    create_join_table :platforms, :products do |t|
      t.index [:platform_id, :product_id]
      t.index [:product_id, :platform_id]
    end
  end
end
