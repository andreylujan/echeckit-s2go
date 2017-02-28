class AddKamToDealers < ActiveRecord::Migration
  def change
    add_column :dealers, :kam, :text
  end
end
