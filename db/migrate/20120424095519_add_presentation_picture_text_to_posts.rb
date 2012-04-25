class AddPresentationPictureTextToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :presentation_picture_text, :string
  end
end
