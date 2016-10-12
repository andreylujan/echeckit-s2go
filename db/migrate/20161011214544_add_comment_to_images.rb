class AddCommentToImages < ActiveRecord::Migration
  def change
    add_column :images, :comment, :text
  end
end
