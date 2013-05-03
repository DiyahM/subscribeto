class AddPaymentDueToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :payment_due, :integer
  end
end
