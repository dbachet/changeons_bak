# -*- encoding : utf-8 -*-
class AddColumnRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string
  end

  def self.down
    remove_column :users, :role
  end
end
