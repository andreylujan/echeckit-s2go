class AddEmergencyPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :emergency_phone, :integer, null: false, default: 0
  end
end
