class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :position
      t.text :title
      t.references :organization, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
