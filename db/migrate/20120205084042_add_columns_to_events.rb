class AddColumnsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :picture_height, :integer
    add_column :events, :picture_width, :integer
    add_column :events, :has_big_picture, :boolean
  end

  def self.down
    remove_column :events, :has_big_picture
    remove_column :events, :picture_width
    remove_column :events, :picture_height
  end
end
