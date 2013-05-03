class RemoveDueDateFromPaymentDue < ActiveRecord::Migration
  def up
    remove_column :payment_dues, :due_date
  end

  def down
    add_column :payment_dues, :due_date, :string
  end
end
