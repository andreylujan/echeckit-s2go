class CreatePictures < ActiveRecord::Migration
  def change

    create_table :pictures do |t|
      t.text :url
      t.references :data_part, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    create_table :categories_pictures, id: false do |t|
        t.references :category, index: true
        t.references :picture, index: true
    end
    
  end
end
