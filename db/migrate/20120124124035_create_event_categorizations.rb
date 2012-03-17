# -*- encoding : utf-8 -*-
class CreateEventCategorizations < ActiveRecord::Migration
  def self.up
    create_table :event_categorizations do |t|
      t.integer :event_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_categorizations
  end
end
