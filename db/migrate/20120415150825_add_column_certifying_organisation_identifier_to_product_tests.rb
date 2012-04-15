class AddColumnCertifyingOrganisationIdentifierToProductTests < ActiveRecord::Migration
  def change
    add_column :product_tests, :certifying_organization_identifier, :string
  end
end
