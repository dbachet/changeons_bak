# -*- encoding : utf-8 -*-
class AddChangeAddrStreetToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :addr_street_2, :string
    rename_column :events, :addr_street, :addr_street_1
  end

  def self.down
    remove_column :events, :addr_street_2
    rename_column :events, :addr_street_1, :addr_street
  end
end
