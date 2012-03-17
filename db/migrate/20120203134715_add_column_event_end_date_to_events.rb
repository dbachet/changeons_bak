# -*- encoding : utf-8 -*-
class AddColumnEventEndDateToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :event_end_date, :datetime
  end

  def self.down
    remove_column :events, :event_end_date
  end
end
