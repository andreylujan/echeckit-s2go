class AddAcceptedToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :accepted, :boolean, null: false, default: false
  end
end
