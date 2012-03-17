# -*- encoding : utf-8 -*-
class CreateProductTests < ActiveRecord::Migration
  def self.up
    create_table :product_tests do |t|
      t.string :brand
      t.string :product_model
      t.string :product_ref
      t.text :description
      t.text :opinion
      t.text :advantages
      t.text :drawbacks
      t.decimal :recommended_price, :precision => 7, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :product_tests
  end
end
