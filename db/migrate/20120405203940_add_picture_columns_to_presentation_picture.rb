class AddPictureColumnsToPresentationPicture < ActiveRecord::Migration
  def self.up
    change_table :presentation_pictures do |t|
      t.has_attached_file :picture
    end
  end

  def self.down
    drop_attached_file :presentation_pictures, :picture
  end
end
