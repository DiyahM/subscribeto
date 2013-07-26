class AddInvoiceIdToDeliveryDetails < ActiveRecord::Migration
  def change
    add_column :delivery_details, :invoice_id, :integer
  end
end
