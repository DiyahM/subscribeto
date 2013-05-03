class PaymentDue < ActiveRecord::Base
  attr_accessible :amount, :due_date, :order_id, :paid
  belongs_to :order
end
