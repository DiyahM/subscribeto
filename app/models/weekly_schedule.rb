class WeeklySchedule < ActiveRecord::Base
  attr_accessible :user_id, :week_start, :delivery_dates_attributes
  belongs_to :user
  has_many :delivery_dates, :dependent => :destroy
  has_many :customers, through: :delivery_dates, :uniq => true
  has_many :delivery_details, through: :delivery_dates
  has_many :order_quantities, through: :delivery_details
  has_many :items, through: :order_quantities, :uniq => true
  has_many :invoices, :dependent => :destroy
  validates :week_start, uniqueness: true
  accepts_nested_attributes_for :delivery_dates
  after_save :create_invoices_for_week

  def self.find_or_initialize_by(week_start, user_id)
    schedule = WeeklySchedule.find_by_week_start_and_user_id(week_start, user_id)
    if schedule.nil?
      schedule = WeeklySchedule.where(user_id: user_id).last
      if schedule.nil?
        schedule = ScheduleCreator.create_schedule(week_start, user_id)
      else
        schedule = ScheduleCreator.set_schedule_from_last(week_start, schedule)
      end
    end
    return schedule
  end

  def create_invoices_for_week
    InvoiceGenerator.create_invoices_for_week(self)
  end

  def end_of_week
    week_start.end_of_week(:sunday)
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
