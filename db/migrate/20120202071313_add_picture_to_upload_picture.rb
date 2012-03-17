# -*- encoding : utf-8 -*-
class AddPictureToUploadPicture < ActiveRecord::Migration
  def self.up
    add_column :upload_pictures, :post_picture_file_name,    :string
    add_column :upload_pictures, :post_picture_content_type, :string
    add_column :upload_pictures, :post_picture_file_size,    :integer
    add_column :upload_pictures, :post_picture_updated_at,   :datetime
  end

  def self.down
    remove_column :upload_pictures, :post_picture_file_name
    remove_column :upload_pictures, :post_picture_content_type
    remove_column :upload_pictures, :post_picture_file_size
    remove_column :upload_pictures, :post_picture_updated_at
  end
end
