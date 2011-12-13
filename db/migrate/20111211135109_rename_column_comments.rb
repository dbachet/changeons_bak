class RenameColumnComments < ActiveRecord::Migration
  def self.up
    rename_column :comments, :send_notification_when_reply_my_comment, :send_notification_to_root_comment
  end

  def self.down
    rename_column :comments, :send_notification_to_root_comment, :send_notification_when_reply_my_comment
  end
end
