# -*- encoding : utf-8 -*-
class RemoveAmountFromMonthlySales < ActiveRecord::Migration
  def change
    remove_column :monthly_sales, :amount, :integer
  end
end
