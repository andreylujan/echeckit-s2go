class ChangeEmergencyPhoneTypeInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :emergency_phone, :text, null: false, default: ''
  end
end
