class RenamePostPictureToPosts < ActiveRecord::Migration
  def self.up
      rename_column :posts, :post_picture_file_name, :picture_file_name
      rename_column :posts, :post_picture_content_type, :picture_content_type
      rename_column :posts, :post_picture_file_size, :picture_file_size
      rename_column :posts, :post_picture_updated_at, :picture_updated_at
    end

    def self.down
      # rename back if you need or do something else or do nothing
    end
end
