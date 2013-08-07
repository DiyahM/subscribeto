class AddInvoiceNumberToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :invoice_number, :integer
  end
end
