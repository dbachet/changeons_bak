class CreatePresentationPictures < ActiveRecord::Migration
  def self.up
    create_table :presentation_pictures do |t|
        t.string :name
        t.references :presentation_picturable, :polymorphic => true
        t.timestamps
    end
  end

  def self.down
    drop_table :presentation_pictures
  end
end