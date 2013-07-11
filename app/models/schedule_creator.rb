class ScheduleCreator

  def self.create_schedule(week_start, user_id)
    schedule = WeeklySchedule.new(week_start: week_start, user_id: user_id)
    DeliverySlot.all.each do |slot|
      delivery_date = schedule.delivery_dates.build(scheduled_for: slot.get_date_for(schedule.week_start),
                                                    delivery_slot_id: slot.id)
      slot.customers.each do |customer|
        delivery_detail = delivery_date.delivery_details.build(customer_id: customer.id)
        schedule.user.items.each do |item|
          delivery_detail.order_quantities.build(item_id: item.id)
        end
      end
    end    
    return schedule
  end

  def self.set_schedule(schedule)
    schedule.delivery_dates.each do |delivery_date|
      delivery_date.scheduled_for = delivery_date.delivery_slot.get_date_for(schedule.week_start) 
    end
  end 
end
