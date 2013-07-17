class OrderQuantity < ActiveRecord::Base
  attr_accessible :delivery_detail_id, :item_id, :quantity
  belongs_to :delivery_detail  
  belongs_to :item  
  belongs_to :weekly_schedule

  def subtotal
    item.price * quantity
  end
  
end
