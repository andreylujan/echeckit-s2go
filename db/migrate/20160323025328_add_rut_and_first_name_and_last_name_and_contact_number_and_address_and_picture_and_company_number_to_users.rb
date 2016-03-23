class AddRutAndFirstNameAndLastNameAndContactNumberAndAddressAndPictureAndCompanyNumberToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rut, :text
    add_column :users, :first_name, :text
    add_column :users, :last_name, :text
    add_column :users, :phone_number, :text
    add_column :users, :address, :text
    add_column :users, :picture, :text

    add_index :users, :rut, unique: true
  end
end
