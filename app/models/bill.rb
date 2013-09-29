class Bill < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :weekly_schedule_id, :customer_id, :user_id, :delivery_slot_id, :invoice_id, :scheduled_for, :order_items_attributes

  belongs_to :customer
  belongs_to :invoice
  belongs_to :delivery_slot
  belongs_to :weekly_schedule
  belongs_to :user

  has_many :order_items

  accepts_nested_attributes_for :order_items, :allow_destroy => true#, :reject_if => {|order_item| order_item[:item_id].blank? or order_item[:price_charged].blank?}

  def build_order_items(associated_attributes={})
    user.items.all.each do |item|
      self.order_items.build(item_id: item.id,
                              price_charged: item.price,
                              quantity: 0,
                              qty_delivered: 0,
                              qty_returned: 0
                            )
    end
  end
end
