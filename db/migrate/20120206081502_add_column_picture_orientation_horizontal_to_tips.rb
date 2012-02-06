class AddColumnPictureOrientationHorizontalToTips < ActiveRecord::Migration
  def self.up
    add_column :tips, :picture_orientation_horizontal, :boolean
  end

  def self.down
    remove_column :tips, :picture_orientation_horizontal
  end
end
