class LineItem < ActiveRecord::Base
  attr_accessible :delivery_slot_id, :order_id, :quantity, :item_id
  belongs_to :order
  belongs_to :delivery_slot
  belongs_to :item

  validates :quantity, :numericality => {:greater_than => 0}
end
