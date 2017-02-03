class RemoveOrganizationFromCategories < ActiveRecord::Migration
  def change
    remove_reference :categories, :organization, index: true, foreign_key: true
  end
end
