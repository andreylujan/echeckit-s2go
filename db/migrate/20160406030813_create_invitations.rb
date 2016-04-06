class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :role, index: true, foreign_key: true, null: false
      t.text :confirmation_token, null: false
      t.text :email, null: false
      t.timestamps null: false
    end
    add_index :invitations, :email, unique: true
  end
end
