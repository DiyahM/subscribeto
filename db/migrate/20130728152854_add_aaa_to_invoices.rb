class AddAaaToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :archive_number, :string
    add_column :invoices, :archived_at, :datetime
  end
end
