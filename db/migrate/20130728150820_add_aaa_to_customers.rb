class AddAaaToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :archive_number, :string
    add_column :customers, :archived_at, :datetime
  end
end
