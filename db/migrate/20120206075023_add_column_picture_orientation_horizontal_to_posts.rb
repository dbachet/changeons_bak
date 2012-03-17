# -*- encoding : utf-8 -*-
class AddColumnPictureOrientationHorizontalToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :picture_orientation_horizontal, :boolean
  end

  def self.down
    remove_column :posts, :picture_orientation_horizontal
  end
end
