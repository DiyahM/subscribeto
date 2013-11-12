class OrderItem < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  
  attr_accessible :delivery_detail_id, :item_id, :quantity, :qty_delivered, :qty_returned, :price_charged

  belongs_to :delivery_detail
  belongs_to :item  
  belongs_to :invoice
  belongs_to :bill

  validates_presence_of :item_id

  def item_name
    self.item.name
  end

  def subtotal
    price_charged * qty_delivered
  end

  def quantity_iif
    0 - quantity
  end

  def subtotal_iif
    0 - subtotal
  end

  def week
    bill.weekly_schedule
  end

  def delivery_date
    delivery_detail.delivery_date.scheduled_for.strftime("%m/%d/%y")
  end
end
