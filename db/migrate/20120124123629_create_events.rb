# -*- encoding : utf-8 -*-
class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :event_date

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
