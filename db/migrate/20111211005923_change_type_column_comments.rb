# -*- encoding : utf-8 -*-
class ChangeTypeColumnComments < ActiveRecord::Migration
  def self.up
    
    change_column :comments, :send_notification_when_reply_my_comment, :integer
  end

  def self.down
    change_column :comments, :send_notification_when_reply_my_comment, :boolean
  end
end
