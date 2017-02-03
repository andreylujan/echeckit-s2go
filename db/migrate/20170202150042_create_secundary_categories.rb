class CreateSecundaryCategories < ActiveRecord::Migration
  def change
    create_table :secundary_categories do |t|
      t.string :name
      t.references :principalcategory, index: true, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
