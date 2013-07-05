class DeliveryDetail < ActiveRecord::Base
  attr_accessible :customer_id, :delivery_date_id, :item_id, :qty_ordered
  belongs_to :item
  belongs_to :customer
  belongs_to :delivery_date
end
