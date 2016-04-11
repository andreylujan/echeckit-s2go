class AddSectionTypeReferenceToSections < ActiveRecord::Migration
  def change
    add_reference :sections, :section_type, index: true, foreign_key: true, null: false
  end
end
