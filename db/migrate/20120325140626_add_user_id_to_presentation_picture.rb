class AddUserIdToPresentationPicture < ActiveRecord::Migration
  def self.up
    add_column :presentation_pictures, :user_id, :integer
  end

  def self.down
    remove_column :presentation_pictures, :user_id
  end
end
