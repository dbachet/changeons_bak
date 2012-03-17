# -*- encoding : utf-8 -*-
class AddColumnSourcesToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :sources, :text
  end

  def self.down
    remove_column :questions, :sources
  end
end
