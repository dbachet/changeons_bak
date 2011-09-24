class CreatePostTypes < ActiveRecord::Migration
  def self.up
    create_table :post_types do |t|
      t.string :name
      t.string :cached_slug

      t.timestamps
    end
  end

  def self.down
    drop_table :post_types
  end
end
