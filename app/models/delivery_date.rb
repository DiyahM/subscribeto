class DeliveryDate < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  default_scope DeliveryDate.unarchived
  attr_accessible :scheduled_for, :weekly_schedule_id, :delivery_details_attributes, :delivery_slot_id
  has_many :delivery_details, :dependent => :destroy 
  has_many :customers, through: :delivery_details
  has_many :order_quantities, through: :delivery_details
  belongs_to :delivery_slot
  belongs_to :weekly_schedule
  accepts_nested_attributes_for :delivery_details

  def items
    my_items = {}
    order_quantities.each do |order|
      if order.quantity > 0
        if !my_items[order.item.name].nil?
          my_items[order.item.name] += order.quantity
        else
          my_items[order.item.name] = order.quantity
        end
      end
    end
    return my_items
  end

  def customers_with_orders
    my_customers = []
    order_quantities.each do |order|
      if order.quantity > 0
        customer = order.delivery_detail.customer
        my_customers << customer unless my_customers.include? customer
      end
    end
    return my_customers
  end

  def items_by_customer(customer_id)
    my_items = {}
    detail = delivery_details.find_by_customer_id(customer_id)
    detail.order_quantities.each do |order|
      if order.quantity > 0
        if !my_items[order.item.name].nil?
          my_items[order.item.name] += order.quantity
        else
          my_items[order.item.name] = order.quantity
        end
      end
    end
    return my_items
  end 

end
