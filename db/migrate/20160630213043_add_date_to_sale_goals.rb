class AddDateToSaleGoals < ActiveRecord::Migration
  def change
    add_column :sale_goals, :date, :datetime
  end
end
