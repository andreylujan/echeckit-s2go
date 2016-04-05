class AddZoneReferenceAndContactAndPhoneNumberAndAddressToStores < ActiveRecord::Migration
  def change
    add_reference :stores, :zone, index: true, foreign_key: true, null: false
    add_column :stores, :contact, :text
    add_column :stores, :phone_number, :text
    add_column :stores, :address, :text
  end
end
