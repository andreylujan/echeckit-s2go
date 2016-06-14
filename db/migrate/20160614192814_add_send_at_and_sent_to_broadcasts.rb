class AddSendAtAndSentToBroadcasts < ActiveRecord::Migration
  def change
    add_column :broadcasts, :send_at, :datetime
    add_column :broadcasts, :sent, :boolean
  end
end
