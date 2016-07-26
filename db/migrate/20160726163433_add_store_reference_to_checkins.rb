class AddStoreReferenceToCheckins < ActiveRecord::Migration
  def change
    add_reference :checkins, :store, index: true, foreign_key: true
  end
end
