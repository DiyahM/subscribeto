class PaymentRecvd < ActiveRecord::Base
  attr_accessible :payment_amount, :order_id
  belongs_to :order
end
