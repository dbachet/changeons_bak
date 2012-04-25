class AddPresentationPictureTextToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :presentation_picture_text, :string
  end
end
