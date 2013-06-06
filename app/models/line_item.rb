class LineItem < ActiveRecord::Base
  attr_accessible :delivery_slot_id, :order_id, :quantity, :item_id, :delivered, :price, :qty_delivered, :qty_returned
  belongs_to :order
  belongs_to :delivery_slot
  belongs_to :item
  after_create :set_default_values
  after_save :update_order_status

  validates :quantity, :numericality => {:greater_than => 0}
  validates :delivery_slot_id, :quantity, :item_id, :price, presence: true

  def self.mark_batch_delivered(ids)
    if ids.any?
      ids.each do |line_item_id|
        line_item = LineItem.find(line_item_id)
        line_item.delivered = true
        line_item.save
      end
    end
  end

  def update_order_status
    Order.update_status(self.order_id)
  end

  def total
    (qty_delivered - qty_returned) *price
  end
  def self.undelivered_for_day(delivery_slots, user_id)
    undelivered_items = []
    delivery_slots.each do |slot|
      items = LineItem.where("delivery_slot_id = ? AND delivered = ?", slot.id, false).where(order_id: Order.where(user_id: user_id))
      undelivered_items += items
    end
    return undelivered_items
  end

  private
  
  def set_default_values
    self.delivered = false
    self.qty_delivered = quantity
    self.save
  end
  
end
