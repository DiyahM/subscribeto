class AddInvoiceIdToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :invoice_id, :integer
  end
end
