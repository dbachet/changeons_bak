class AddPresentationPictureTextToProductTests < ActiveRecord::Migration
  def change
    add_column :product_tests, :presentation_picture_text, :string
  end
end
