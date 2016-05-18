class RemoveJoinTablesFromStores < ActiveRecord::Migration
  def change
  	Zone.all.each do |zone|
  		zone.dealers.each do |dealer|
  			dealer.stores.each do |store|
  				s = store.dup
  				s.dealer = dealer
  				s.zone = zone
  				s.save!
  			end
  		end
  	end
  	drop_table :dealers_stores
  	drop_table :stores_zones
  end
end
