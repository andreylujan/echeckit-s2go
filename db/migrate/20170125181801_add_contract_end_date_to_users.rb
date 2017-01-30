class AddContractEndDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contract_end_date, :datetime, null: true
  end
end
