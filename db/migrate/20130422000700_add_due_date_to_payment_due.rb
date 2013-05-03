class AddDueDateToPaymentDue < ActiveRecord::Migration
  def change
    add_column :payment_dues, :due_date, :datetime
  end
end
