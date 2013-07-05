class ScheduleCreator

  def self.set_schedule(schedule)
    DeliverySlot.all.each do |slot|
      delivery_date = schedule.delivery_dates.build(scheduled_for: slot.get_date_for(schedule.week_start),
                                                   delivery_slot_id: slot.id)
      slot.customers.each do |customer|
        schedule.user.items.each do |item|
          last_order = DeliveryDetail.where(customer_id: customer.id, item_id: item.id).order("updated_at DESC").limit(1)
          if last_order.empty?
            delivery_date.delivery_details.build(customer_id: customer.id, item_id: item.id, qty_ordered: 0)
          else
            delivery_date.delivery_details << last_order.dup
          end
        end
      end
    end
  end
end
