class AddCachedSlugToProductTests < ActiveRecord::Migration
  def self.up
    add_column :product_tests, :cached_slug, :string
  end

  def self.down
    remove_column :product_tests, :cached_slug
  end
end
