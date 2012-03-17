# -*- encoding : utf-8 -*-
class RenameEventDateToEvents < ActiveRecord::Migration
  def self.up
      rename_column :events, :event_date, :event_start_date
    end

    def self.down
      # rename back if you need or do something else or do nothing
    end
end
