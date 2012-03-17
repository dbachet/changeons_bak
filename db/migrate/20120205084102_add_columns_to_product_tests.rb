# -*- encoding : utf-8 -*-
class AddColumnsToProductTests < ActiveRecord::Migration
  def self.up
    add_column :product_tests, :picture_height, :integer
    add_column :product_tests, :picture_width, :integer
    add_column :product_tests, :has_big_picture, :boolean
  end

  def self.down
    remove_column :product_tests, :has_big_picture
    remove_column :product_tests, :picture_width
    remove_column :product_tests, :picture_height
  end
end
