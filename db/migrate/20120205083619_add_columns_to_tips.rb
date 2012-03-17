# -*- encoding : utf-8 -*-
class AddColumnsToTips < ActiveRecord::Migration
  def self.up
    add_column :tips, :picture_height, :integer
    add_column :tips, :picture_width, :integer
    add_column :tips, :has_big_picture, :boolean
  end

  def self.down
    remove_column :tips, :has_big_picture
    remove_column :tips, :picture_width
    remove_column :tips, :picture_height
  end
end
