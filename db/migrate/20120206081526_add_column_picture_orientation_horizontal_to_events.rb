class AddColumnPictureOrientationHorizontalToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :picture_orientation_horizontal, :boolean
  end

  def self.down
    remove_column :events, :picture_orientation_horizontal
  end
end
