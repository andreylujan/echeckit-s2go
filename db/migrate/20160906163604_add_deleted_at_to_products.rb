class AddDeletedAtToProducts < ActiveRecord::Migration
  def change
    add_column :products, :deleted_at, :string
    add_index :products, :deleted_at
  end
end
