# -*- encoding : utf-8 -*-
class AddColumnTitleToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :title, :string
  end

  def self.down
    remove_column :questions, :title
  end
end
