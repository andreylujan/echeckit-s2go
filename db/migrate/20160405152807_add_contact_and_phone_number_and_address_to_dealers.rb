class AddContactAndPhoneNumberAndAddressToDealers < ActiveRecord::Migration
  def change
    add_column :dealers, :contact, :text
    add_column :dealers, :phone_number, :text
    add_column :dealers, :address, :text
  end
  add_index :dealers, :name, unique: true
end
