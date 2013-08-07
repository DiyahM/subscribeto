class OrderQuantity < ActiveRecord::Base
  attr_accessible :delivery_detail_id, :item_id, :quantity, :qty_delivered, :qty_returned
  belongs_to :delivery_detail  
  belongs_to :item  
  belongs_to :weekly_schedule
  validates_presence_of :item_id
  default_scope includes(:item).order('items.created_at DESC')

  def subtotal
    item.price * quantity
  end
  
end
