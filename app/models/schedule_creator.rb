class ScheduleCreator

  def self.create_schedule(week_start, user_id)
    user = User.find(user_id)
    schedule = WeeklySchedule.new(week_start: week_start, user_id: user_id)
    last_week = WeeklySchedule.find_last_by_user_id(user_id)
    user.delivery_slots.each do |slot|
      delivery_date = schedule.delivery_dates.build(scheduled_for: slot.get_date_for(schedule.week_start),
                                                    delivery_slot_id: slot.id)
      slot.customers.each do |customer|
        delivery_detail = delivery_date.delivery_details.build(customer_id: customer.id)
        schedule.user.items.each do |item|
          order = delivery_detail.order_quantities.build(item_id: item.id)
          if !last_week.nil?
            last_week_slot = last_week.delivery_dates.find_by_delivery_slot_id(slot.id)
            last_detail = last_week_slot.delivery_details.find_by_customer_id(customer.id) if last_week_slot
            last_order = last_detail.order_quantities.find_by_item_id(item.id) if last_detail
            order.quantity = last_order.quantity if last_order
          end
        end
      end
    end    
    return schedule
  end

end
