class AddColumnWrittenAsGuestToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :written_as_guest, :boolean
  end

  def self.down
    remove_column :comments, :written_as_guest
  end
end
