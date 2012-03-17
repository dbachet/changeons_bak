# -*- encoding : utf-8 -*-
class CreateTipCategorization < ActiveRecord::Migration
  def self.up
    create_table :tip_categorizations do |t|
      t.integer :tip_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tip_categorizations
  end
end
