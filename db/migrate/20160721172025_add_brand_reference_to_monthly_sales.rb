class AddBrandReferenceToMonthlySales < ActiveRecord::Migration
  def change
    add_reference :monthly_sales, :brand, index: true, foreign_key: true, null: false
  end
end
