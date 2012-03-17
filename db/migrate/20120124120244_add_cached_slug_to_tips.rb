# -*- encoding : utf-8 -*-
class AddCachedSlugToTips < ActiveRecord::Migration
  def self.up
    add_column :tips, :cached_slug, :string
  end

  def self.down
    remove_column :tips, :cached_slug
  end
end
