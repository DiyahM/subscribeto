class Customer < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  default_scope Customer.unarchived.order('created_at DESC')
  attr_accessible :email, :phone_number, :address_one, :address_two, :city, :state, :postal_code,
    :company_name, :poc_name, :user_id, :note, :term, :delivery_slot_ids
  belongs_to :user
  has_and_belongs_to_many :delivery_slots
  has_many :delivery_details, :dependent => :destroy
  has_many :delivery_dates, through: :delivery_details
  has_many :order_quantities, through: :delivery_details
  has_many :invoices, :dependent => :destroy
  validates_presence_of :email, :company_name
  validates_uniqueness_of :email, scope: :user_id

  def amount_due_for_week(weekly_schedule)
    my_delivery_details = delivery_details_for_week(weekly_schedule)
    total = 0
    my_delivery_details.each do |delivery_detail|
      delivery_detail.order_quantities.each do |order|
        if order.quantity > 0
          total += order.subtotal
        end
      end
    end
    return total
  end

  def delivery_details_for_week(weekly_schedule)
    delivery_details.find_all_by_delivery_date_id(weekly_schedule.delivery_dates)
  end

  def orders
    weekly_orders = []
    my_orders = order_quantities.where("quantity > ?", 0)
    my_orders.each do |my_order|
      weekly_orders.push(my_order.week) unless weekly_orders.include? my_order.week
    end
    return weekly_orders
  end
end
