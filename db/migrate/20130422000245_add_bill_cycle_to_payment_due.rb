class AddBillCycleToPaymentDue < ActiveRecord::Migration
  def change
    add_column :payment_dues, :bill_cycle_start, :datetime
    add_column :payment_dues, :bill_cycle_end, :datetime
  end
end
