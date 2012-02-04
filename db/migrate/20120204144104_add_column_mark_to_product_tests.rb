class AddColumnMarkToProductTests < ActiveRecord::Migration
  def self.up
    add_column :product_tests, :mark, :integer
  end

  def self.down
    remove_column :product_tests, :mark
  end
end
