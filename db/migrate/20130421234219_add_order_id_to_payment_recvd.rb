class AddOrderIdToPaymentRecvd < ActiveRecord::Migration
  def change
    add_column :payment_recvds, :order_id, :integer
  end
end
