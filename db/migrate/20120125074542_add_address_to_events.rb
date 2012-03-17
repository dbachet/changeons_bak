# -*- encoding : utf-8 -*-
class AddAddressToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :addr_street, :string
    add_column :events, :addr_postcode, :string
    add_column :events, :addr_city, :string
    add_column :events, :addr_country, :string
  end

  def self.down
    remove_column :events, :addr_country
    remove_column :events, :addr_city
    remove_column :events, :addr_postcode
    remove_column :events, :addr_street
  end
end
