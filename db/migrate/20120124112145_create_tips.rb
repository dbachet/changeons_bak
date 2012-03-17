# -*- encoding : utf-8 -*-
class CreateTips < ActiveRecord::Migration
  def self.up
    create_table :tips do |t|
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tips
  end
end
