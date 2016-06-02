class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user, index: true, foreign_key: true
      t.text :device_token
      t.text :registration_id
      t.text :uuid
      t.text :architecture
      t.text :address
      t.text :locale
      t.text :manufacturer
      t.text :model
      t.text :name
      t.text :os_name
      t.integer :processor_count
      t.text :version
      t.text :os_type

      t.timestamps null: false
    end
  end
end
