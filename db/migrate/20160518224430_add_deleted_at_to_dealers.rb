class AddDeletedAtToDealers < ActiveRecord::Migration
  def change
    add_column :dealers, :deleted_at, :datetime
    add_index :dealers, :deleted_at
  end
end
