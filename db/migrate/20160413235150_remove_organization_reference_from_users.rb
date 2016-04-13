class RemoveOrganizationReferenceFromUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :organization, index: true, foreign_key: true
  end
end
