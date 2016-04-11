class CreateSubsectionItemTypes < ActiveRecord::Migration
  def change
    create_table :subsection_item_types do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
