class WeeklySchedule < ActiveRecord::Base

  attr_accessible :user_id, :week_start, :bills_attributes
  
  belongs_to :user
  
  # has_many :delivery_dates, :dependent => :destroy
  # has_many :customers, through: :delivery_dates, :uniq => true
  # has_many :delivery_details, through: :delivery_dates
  # has_many :order_items, through: :delivery_details
  # has_many :items, through: :order_items, :uniq => true
  has_many :invoices, :dependent => :destroy

  has_many :bills
  has_many :delivery_slots, through: :bills
  accepts_nested_attributes_for :bills

  validates_uniqueness_of :week_start, scope: :user_id
  
  # accepts_nested_attributes_for :delivery_dates
  
  after_save :create_invoices_for_week

  def self.find_or_initialize_by(week_start, user_id)
    schedule = WeeklySchedule.find_by_week_start_and_user_id(week_start, user_id)
    user = User.find(user_id)
    puts "*" * 100
    logger.info schedule.inspect 
    unless schedule
      schedule = WeeklySchedule.new(week_start: week_start)
      user.delivery_slots.each do |slot|
        user.customers.includes(:delivery_slots).each do |customer|
          if customer.delivery_slots.include?(slot)
            schedule.bills.build(customer_id: customer.id, 
                                  user_id: user_id, 
                                  scheduled_for: slot.get_date_for(week_start), 
                                  delivery_slot_id: slot.id)
          end
        end
      end
      schedule.bills.each { |bill| bill.build_order_items }
    else
      schedule.bills.each { |bill| bill.build_order_items }
    end
    schedule
  end

  # def self.find_or_initialize_by(week_start, user_id)
  #   schedule = WeeklySchedule.find_by_week_start_and_user_id(week_start, user_id)

  #   if schedule.nil?
  #     schedule = ScheduleCreator.create_schedule(week_start, user_id)
  #   else
  #     schedule.check_for_changes
  #     schedule.reload
  #   end
  #   return schedule
  # end

  def line_items_for_customer(customer_id)
    ret_line_items = []
    my_line_items = delivery_details.find_all_by_customer_id(customer_id)
    my_line_items.each do |my_line_item|
      my_line_item.order_items.each do |order|
        if order.quantity > 0
          ret_line_items.push(order) unless ret_line_items.include? order
        end
      end
    end
    return ret_line_items
  end

  # def check_for_changes
  #   user.delivery_slots.includes(:customers).each do |slot|
  #     if delivery_dates.where(delivery_slot_id: slot.id).empty?
  #       delivery_date = delivery_dates.create(scheduled_for: slot.get_date_for(week_start),
  #                                                     delivery_slot_id: slot.id)
  #       slot.customers.each do |customer|
  #         if delivery_details.where(customer_id: customer.id).empty?
  #           delivery_detail = delivery_date.delivery_details.create(customer_id: customer.id)
  #           user.items.each do |item|
  #             delivery_detail.order_items.create(item_id: item.id)
  #           end
  #         end
  #       end
  #     end
  #   end

  #   user.customers.each do |customer|
  #     customer.delivery_slots.each do |slot|
  #       delivery_date = delivery_dates.find_by_delivery_slot_id(slot.id)
  #       if delivery_date.delivery_details.where(customer_id: customer.id).empty?
  #         delivery_detail = delivery_date.delivery_details.create(customer_id: customer.id)
  #         user.items.each do |item|
  #           delivery_detail.order_items.create(item_id: item.id)
  #         end
  #       end
  #     end    
  #   end

  #   new_items = user.items - items
  #   if new_items.any?
  #     new_items.each do |item|
  #       delivery_details.each do |delivery_detail|
  #         if delivery_detail.order_items.where(item_id: item.id).empty?
  #           delivery_detail.order_items.create(item_id: item.id)
  #         end
  #       end
  #     end
  #   end
  # end

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
    my_orders = order_items.where("item_id = ? and quantity > ?", item_id, 0)
    count = 0
    my_orders.each do |order|
      count += order.quantity
    end
    return count
  end

  def sunday
    items_by_day("Sunday") 
  end

  def monday
    items_by_day("Monday")
  end

  def tuesday
    items_by_day("Tuesday")
  end

  def wednesday
    items_by_day("Wednesday")
  end

  def thursday
    items_by_day("Thursday")
  end

  def friday
    items_by_day("Friday")
  end

  def saturday
    items_by_day("Saturday")
  end

  def items_by_day(day)
    slots = delivery_slots_for_day(day) 
    my_items = {}
    slots.each do |slot|
      slot.order_items.each do |order_item|
        if order_item.quantity > 0
          if !my_items[order_item.item.name].nil?
            my_items[order_item.item.name] += order_item.quantity
          else
            my_items[order_item.item.name] = order_item.quantity
          end
        end
      end
    end
    return my_items
  end

  def delivery_slots_for_day(day)   #delivery_routes_for_day
    delivery_slots_ids = delivery_slots.find_all_by_day(day)
    # delivery_dates.find_all_by_delivery_slot_id(delivery_slots_ids)
  end
end
