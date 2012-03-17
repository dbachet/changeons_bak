# -*- encoding : utf-8 -*-
class AddColumnSourcesToProductTests < ActiveRecord::Migration
  def self.up
    add_column :product_tests, :sources, :text
  end

  def self.down
    remove_column :product_tests, :sources
  end
end
