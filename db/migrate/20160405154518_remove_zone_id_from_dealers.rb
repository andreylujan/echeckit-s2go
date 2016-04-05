class RemoveZoneIdFromDealers < ActiveRecord::Migration
  def change
    remove_column :dealers, :zone_id, :integer
  end
end
