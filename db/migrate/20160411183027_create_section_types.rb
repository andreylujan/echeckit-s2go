class CreateSectionTypes < ActiveRecord::Migration
  def change
    create_table :section_types do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
