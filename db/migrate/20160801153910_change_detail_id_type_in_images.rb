class ChangeDetailIdTypeInImages < ActiveRecord::Migration
  def change
  	change_column :images, :detail_id, :integer, limit: 8
  end
end
