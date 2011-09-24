class AddColumnPostTypeIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :post_type_id, :integer
  end

  def self.down
    remove_column :posts, :post_type_id
  end
end
