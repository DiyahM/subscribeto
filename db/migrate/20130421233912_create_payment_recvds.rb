class CreatePaymentRecvds < ActiveRecord::Migration
  def change
    create_table :payment_recvds do |t|
      t.integer :payment_amount

      t.timestamps
    end
  end
end
