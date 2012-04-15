class AddCertificationOrganismToProductTests < ActiveRecord::Migration
  def change
    add_column :product_tests, :certification_organism, :string
  end
end
