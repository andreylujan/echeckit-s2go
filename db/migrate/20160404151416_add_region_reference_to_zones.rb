class AddRegionReferenceToZones < ActiveRecord::Migration
  def change
    add_reference :zones, :region, index: true, foreign_key: true, null: false
  end
end
