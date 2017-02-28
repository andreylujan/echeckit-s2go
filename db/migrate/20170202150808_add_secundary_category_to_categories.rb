class AddSecundaryCategoryToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :secundary_category, index: true, foreign_key: true
  end
end
