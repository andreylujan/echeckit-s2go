class CreatePrincipalcategories < ActiveRecord::Migration
  def change
    create_table :principalcategories do |t|
      t.string :name
      t.references :organization, index: true, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
