class DeliveryDetail < ActiveRecord::Base
  attr_accessible :customer_id, :delivery_date_id, :invoice_id, :order_quantities_attributes
  has_many :order_quantities, :dependent => :destroy
  belongs_to :customer
  belongs_to :delivery_date
  belongs_to :invoice
  accepts_nested_attributes_for :order_quantities
  
end
