class ChangeColumnRecommendedPriceInProductTests < ActiveRecord::Migration
  def self.up
    change_column :product_tests, :recommended_price, :decimal, :precision => 7, :scale => 2, :default => nil, :null => true
  end

  def self.down
    change_column :product_tests, :recommended_price, :decimal, :precision => 7, :scale => 2
  end
end
