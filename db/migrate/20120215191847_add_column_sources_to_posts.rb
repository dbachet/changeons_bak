# -*- encoding : utf-8 -*-
class AddColumnSourcesToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :sources, :text
  end

  def self.down
    remove_column :posts, :sources
  end
end
