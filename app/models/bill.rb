class Bill < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :weekly_schedule_id, :customer_id, :user_id, :delivery_slot_id, :invoice_id, :scheduled_for, :order_items_attributes

  belongs_to :customer
  belongs_to :invoice
  belongs_to :delivery_slot
  belongs_to :weekly_schedule
  belongs_to :user

  has_many :order_items

  accepts_nested_attributes_for :order_items, :allow_destroy => true, :reject_if => lambda { |order_item| order_item[:item_id].blank? or order_item[:qty_delivered].blank? or (order_item[:qty_delivered].to_i < 1 and order_item[:qty_returned].to_i < 1 and order_item[:quantity].to_i < 1) }

  before_save :delete_zero_delivered_items

  def build_order_items(last_schedule_id,associated_attributes={})
    user.items.all.each do |item|
      unless self.order_items.map(&:item_id).include?(item.id)
        if !self.new_record? or self.last_bill(last_schedule_id).blank?
          self.order_items.build(item_id: item.id,
                                  price_charged: item.price,
                                  quantity: 0,
                                  qty_delivered: 0,
                                  qty_returned: 0
                                )
        elsif self.last_bill(last_schedule_id)
          self.order_items.build(item_id: item.id,
                                  price_charged: item.price,
                                  quantity: self.last_bill(last_schedule_id).find_item(item.id, "quantity"),
                                  qty_delivered: self.last_bill(last_schedule_id).find_item(item.id, "qty_delivered"),
                                  qty_returned: self.last_bill(last_schedule_id).find_item(item.id, "qty_returned")
                                )
        end
      end
      
    end
  end

  def find_item(passed_item_id, asked_attribute)
    found_item = self.order_items.where(item_id: passed_item_id).first
    unless found_item.nil?
      case asked_attribute
      when "quantity"
        found_item.quantity
      when "qty_returned"
        found_item.qty_returned
      when "qty_delivered"
        found_item.qty_delivered
      else
        0
      end
    else
      0
    end
  end

  def enough_items_delivered?
    self.order_items.map(&:qty_delivered).sum > 0 ? true : false
  end

  def last_bill(passed_weekly_schedule_id)
    Bill.where(weekly_schedule_id: passed_weekly_schedule_id, delivery_slot_id: self.delivery_slot_id, user_id: self.user_id, customer_id: self.customer_id).first
  end

  def delete_zero_delivered_items
    self.order_items.each do |item|
      item.delete if item.qty_delivered < 1
    end
  end

  def amount_due
    total = 0
    order_items.each do |order_item|  
      total += order_item.subtotal
    end
    return total
  end

end
