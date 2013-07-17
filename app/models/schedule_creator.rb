class ScheduleCreator

  def self.create_schedule(week_start, user_id)
    schedule = WeeklySchedule.new(week_start: week_start, user_id: user_id)
    DeliverySlot.all.each do |slot|
      delivery_date = schedule.delivery_dates.build(scheduled_for: slot.get_date_for(schedule.week_start),
                                                    delivery_slot_id: slot.id)
      slot.customers.each do |customer|
        delivery_detail = delivery_date.delivery_details.build(customer_id: customer.id)
        schedule.user.items.each do |item|
          order = delivery_detail.order_quantities.build(item_id: item.id)
        end
      end
    end    
    return schedule
  end

  def self.set_schedule_from_last(week_start, old_schedule)
    new_schedule = old_schedule.dup
    new_schedule.week_start = week_start
    old_schedule.delivery_dates.each do |delivery_date|
      new_date = DeliveryDate.new(scheduled_for: delivery_date.delivery_slot.get_date_for(new_schedule.week_start),
                       delivery_slot_id: delivery_date.delivery_slot_id)
      delivery_date.delivery_details.each do |delivery_detail|
        new_detail = delivery_detail.dup 
        delivery_detail.order_quantities.each do |item|
          new_item = item.dup
          new_detail.order_quantities << new_item
        end
        new_date.delivery_details << new_detail
      end
      new_schedule.delivery_dates << new_date
    end
    return new_schedule
  end 
end
