class AddColumnsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :picture_height, :integer
    add_column :posts, :picture_width, :integer
    add_column :posts, :has_big_picture, :boolean
  end

  def self.down
    remove_column :posts, :has_big_picture
    remove_column :posts, :picture_width
    remove_column :posts, :picture_height
  end
end
