class AddColumnPictureOrientationHorizontalToProductTests < ActiveRecord::Migration
  def self.up
    add_column :product_tests, :picture_orientation_horizontal, :boolean
  end

  def self.down
    remove_column :product_tests, :picture_orientation_horizontal
  end
end
