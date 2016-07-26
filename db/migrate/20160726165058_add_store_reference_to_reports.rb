class AddStoreReferenceToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :store, index: true, foreign_key: true
  end
end
