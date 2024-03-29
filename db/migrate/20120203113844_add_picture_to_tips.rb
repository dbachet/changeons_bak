# -*- encoding : utf-8 -*-
class AddPictureToTips < ActiveRecord::Migration
  def self.up
    add_column :tips, :picture_file_name,    :string
    add_column :tips, :picture_content_type, :string
    add_column :tips, :picture_file_size,    :integer
    add_column :tips, :picture_updated_at,   :datetime
  end

  def self.down
    remove_column :tips, :picture_file_name
    remove_column :tips, :picture_content_type
    remove_column :tips, :picture_file_size
    remove_column :tips, :picture_updated_at
  end
end
