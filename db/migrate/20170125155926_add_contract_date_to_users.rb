class AddContractDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contract_date, :datetime, null: true
  end
end
