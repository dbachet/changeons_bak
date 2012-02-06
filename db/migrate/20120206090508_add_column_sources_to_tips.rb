class AddColumnSourcesToTips < ActiveRecord::Migration
  def self.up
    add_column :tips, :sources, :text
  end

  def self.down
    remove_column :tips, :sources
  end
end
