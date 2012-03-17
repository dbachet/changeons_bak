# -*- encoding : utf-8 -*-
class AddColumnCachedSlugAndUserIdtoEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :cached_slug, :string
    add_column :events, :user_id, :integer
  end

  def self.down
    remove_column :events, :cached_slug
    remove_column :events, :user_id
  end
end
