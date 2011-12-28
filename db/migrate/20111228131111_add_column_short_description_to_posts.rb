class AddColumnShortDescriptionToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :short_description, :text
  end

  def self.down
    remove_column :posts, :short_description
  end
end
