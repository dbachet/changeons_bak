class AddPresentationPictureTextToEvents < ActiveRecord::Migration
  def change
    add_column :events, :presentation_picture_text, :string
  end
end
