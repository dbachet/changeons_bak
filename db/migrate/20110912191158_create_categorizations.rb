# -*- encoding : utf-8 -*-
class CreateCategorizations < ActiveRecord::Migration
  def self.up
    create_table :categorizations do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :categorizations
  end
end
