class CreateUploadPictures < ActiveRecord::Migration
  def self.up
    create_table :upload_pictures do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :upload_pictures
  end
end
