class RemovePictureColumnsFromPresentationPicture < ActiveRecord::Migration
  def self.up
    remove_column :presentation_pictures, :picture_file_name
    remove_column :presentation_pictures, :picture_content_type
    remove_column :presentation_pictures, :picture_file_size
    remove_column :presentation_pictures, :picture_updated_at
  end
  
  def self.down
    add_column :presentation_pictures, :picture_file_name,    :string
    add_column :presentation_pictures, :picture_content_type, :string
    add_column :presentation_pictures, :picture_file_size,    :integer
    add_column :presentation_pictures, :picture_updated_at,   :datetime
  end
end
