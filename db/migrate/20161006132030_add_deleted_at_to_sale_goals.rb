class AddDeletedAtToSaleGoals < ActiveRecord::Migration
  def change
    add_column :sale_goals, :deleted_at, :datetime
    add_index :sale_goals, :deleted_at
  end
end
