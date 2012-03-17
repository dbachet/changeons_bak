# -*- encoding : utf-8 -*-
class AddColumnGuestEmailAndGuestWebsiteToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :guest_email, :string
    add_column :comments, :guest_website, :string
  end

  def self.down
    remove_column :comments, :guest_website
    remove_column :comments, :guest_email
  end
end
