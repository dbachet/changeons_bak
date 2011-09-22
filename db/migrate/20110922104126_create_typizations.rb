class CreateTypizations < ActiveRecord::Migration
  def self.up
    create_table :typizations do |t|
      t.integer :post_id
      t.integer :type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :typizations
  end
end
