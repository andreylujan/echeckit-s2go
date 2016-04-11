class CreateSubsections < ActiveRecord::Migration
  def change
    create_table :subsections do |t|
      t.references :section, index: true, foreign_key: true
      t.text :name, null: false
      t.text :icon
      t.boolean :has_pictures, null: false, default: true
      t.boolean :has_comment, null: false, default: true
      t.integer :max_pictures, null: false, default: 20
      t.integer :comment_length, null: false, default: 256

      t.timestamps null: false
    end
  end
end
