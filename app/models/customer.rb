class Customer < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  default_scope Customer.unarchived.order('created_at DESC')
  attr_accessible :email, :phone_number, :address_one, :address_two, :city, :state, :postal_code,
    :company_name, :poc_name, :user_id, :note, :term, :delivery_slot_ids
  
  belongs_to :user
  
  has_and_belongs_to_many :delivery_slots
  
  # has_many :delivery_details, :dependent => :destroy
  # has_many :delivery_dates, through: :delivery_details
  has_many :bills
  has_many :weekly_schedules, through: :bills, uniq: true
  has_many :order_items, through: :bills
  has_many :invoices, :dependent => :destroy

  validates_presence_of :email, :company_name
  validates_uniqueness_of :email, scope: :user_id

  def amount_due_for_week(weekly_schedule)
    my_order_items = order_items_for_week(weekly_schedule)
    total = 0
    my_order_items.each do |order_item|  
      if order_item.quantity > 0
        total += order_item.subtotal
      end
    end
    return total
  end

  def order_items_for_week(weekly_schedule)    #delivery_details_for_week
    array = []
    self.bills.where(weekly_schedule_id: weekly_schedule.id).each do |bill|
      array << bill.order_items
    end
    return array.flatten
  end

  def orders
    weekly_orders = []
    my_orders = order_items.where("quantity > ?", 0)
    my_orders.each do |my_order|
      weekly_orders.push(my_order.week) unless weekly_orders.include? my_order.week
    end
    return weekly_orders
  end
end
