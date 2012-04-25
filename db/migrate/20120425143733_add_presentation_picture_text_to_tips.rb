class AddPresentationPictureTextToTips < ActiveRecord::Migration
  def change
    add_column :tips, :presentation_picture_text, :string
  end
end
