class CreatePaymentDues < ActiveRecord::Migration
  def change
    create_table :payment_dues do |t|
      t.integer :amount
      t.integer :due_date
      t.boolean :paid
      t.integer :order_id

      t.timestamps
    end
  end
end
