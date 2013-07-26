class AddMemoToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :memo, :string
  end
end
