class WeeklySchedule < ActiveRecord::Base
  attr_accessible :user_id, :week_start, :delivery_dates_attributes
  belongs_to :user
  has_many :delivery_dates, :dependent => :destroy
  has_many :customers, through: :delivery_dates, :uniq => true
  has_many :delivery_slots, through: :delivery_dates, :uniq => true
  has_many :delivery_details, through: :delivery_dates
  has_many :order_quantities, through: :delivery_details
  has_many :items, through: :order_quantities, :uniq => true
  has_many :invoices, :dependent => :destroy
  validates_uniqueness_of :week_start, scope: :user_id
  accepts_nested_attributes_for :delivery_dates
  after_save :create_invoices_for_week

  def self.find_or_initialize_by(week_start, user_id)
    schedule = WeeklySchedule.includes(:invoices, delivery_dates: [:delivery_slot, delivery_details: [:customer, :order_quantities]]).find_by_week_start_and_user_id(week_start, user_id)
      
    if schedule.nil?
      schedule = ScheduleCreator.create_schedule(week_start, user_id)
    else
      schedule.check_for_changes
      schedule.reload
    end
    return schedule
  end

  def check_for_changes

    new_slots = user.delivery_slots - delivery_slots
    if new_slots.any?
      new_slots.each do |slot|
        delivery_date = delivery_dates.create(scheduled_for: slot.get_date_for(week_start),
                                                      delivery_slot_id: slot.id)
        slot.customers.each do |customer|
          delivery_detail = delivery_date.delivery_details.create(customer_id: customer.id)
          user.items.each do |item|
            delivery_detail.order_quantities.create(item_id: item.id)
          end
        end
      end
    end

    new_customers = user.customers - customers
    if new_customers.any?
      new_customers.each do |customer|
        customer.delivery_slot_ids.each do |slot_id|
          delivery_date = delivery_dates.find_by_delivery_slot(slot_id)
          delivery_detail = delivery_date.delivery_details.create(customer_id: customer.id)
          user.items.each do |item|
            delivery_detail.order_quantities.create(item_id: item.id)
          end
        end
      end
    end

    new_items = user.items - items
    if new_items.any?
      new_items.each do |item|
        delivery_details.each do |delivery_detail|
          delivery_detail.order_quantities.create!(item_id: item.id)
        end
      end 
    end    
  end

  def create_invoices_for_week
    InvoiceGenerator.create_invoices_for_week(self)
  end

  def end_of_week
    week_start.end_of_week(:sunday).utc
  end

  def customer_not_invoiced?(customer_id)
    customer_invoice = invoices.find_by_customer_id(customer_id)
    customer_invoice.nil?
  end

  def item_count(item_id)
    my_orders = order_quantities.where("item_id = ? and quantity > ?", item_id, 0)
    count = 0
    my_orders.each do |order|
      count += order.quantity
    end
    return count
  end
end
