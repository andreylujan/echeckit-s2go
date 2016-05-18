class AddZoneReferenceAndDealerReferenceToStores < ActiveRecord::Migration
  def change
    add_reference :stores, :zone, index: true, foreign_key: true
    add_reference :stores, :dealer, index: true, foreign_key: true
  end
end
