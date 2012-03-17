# -*- encoding : utf-8 -*-
class AddColumnSendNotificationWhenReplyMyCommentToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :send_notification_when_reply_my_comment, :boolean
  end

  def self.down
    remove_column :comments, :send_notification_when_reply_my_comment
  end
end
