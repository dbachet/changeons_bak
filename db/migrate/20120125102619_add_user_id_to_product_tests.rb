class AddUserIdToProductTests < ActiveRecord::Migration
  def self.up
    add_column :product_tests, :user_id, :integer
  end

  def self.down
    remove_column :product_tests, :user_id
  end
end
