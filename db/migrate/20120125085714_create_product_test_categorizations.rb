class CreateProductTestCategorizations < ActiveRecord::Migration
  def self.up
    create_table :product_test_categorizations do |t|
      t.integer :product_test_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :product_test_categorizations
  end
end
