class AddColumnsMoreDetailsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :displayName, :string
    add_column :users, :realName, :string
    add_column :users, :website, :string
    add_column :users, :location, :string
    add_column :users, :birthday, :datetime
    add_column :users, :about_me, :text
  end

  def self.down
    remove_column :users, :about_me
    remove_column :users, :birthday
    remove_column :users, :location
    remove_column :users, :website
    remove_column :users, :realName
    remove_column :users, :displayName
  end
end
