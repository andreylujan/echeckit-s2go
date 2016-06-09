# -*- encoding : utf-8 -*-
class AddOrganizationReferenceToDataParts < ActiveRecord::Migration
  def change
    add_reference :data_parts, :organization, index: true, foreign_key: true, null: true
  end
end
