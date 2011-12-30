class AddColumnPostImageToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :post_image, :text
  end

  def self.down
    remove_column :posts, :post_image
  end
end
