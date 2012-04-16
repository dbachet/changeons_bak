class AddColumnDepartmentToEvents < ActiveRecord::Migration
  def change
    add_column :events, :department, :string
  end
end
