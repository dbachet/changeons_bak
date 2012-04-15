class RenameColumnInProductTests < ActiveRecord::Migration
  def up
    rename_column :product_tests, :certification_organism, :certifying_organization
  end
end
