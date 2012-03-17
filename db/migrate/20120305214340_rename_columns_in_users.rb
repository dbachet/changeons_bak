# -*- encoding : utf-8 -*-
class RenameColumnsInUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :displayName, :display_name
    rename_column :users, :realName, :real_name
  end

  def self.down
    rename_column :users, :display_name, :displayName
    rename_column :users, :real_name, :realName
  end
end
