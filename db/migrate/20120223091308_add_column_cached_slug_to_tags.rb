# -*- encoding : utf-8 -*-
class AddColumnCachedSlugToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :cached_slug, :string
  end

  def self.down
    remove_column :tags, :cached_slug
  end
end
