class DeliverySlot < ActiveRecord::Base
  attr_accessible :day, :start_time, :user_id
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items


  def delivery_label
    day + start_time.strftime(" %l:%M %p")
  end

  def self.orders_by_day(day_of_week, id)
    DeliverySlot.where("day = ? AND user_id = ? ", day_of_week, id).includes(:line_items) 
  end

  def self.count_items(slot_id, item_id)
    count = 0
    slot = DeliverySlot.find(slot_id)
    slot.line_items.each do |line_item|
      if line_item.item_id == item_id
        count += line_item.quantity
      end
    end 
    return count
  end

  def self.items_count_by_day(day_of_week, id)
    item_array = {}
    todays_slots = DeliverySlot.orders_by_day(day_of_week, id)
    todays_slots.each do |slot|
      slot.items.each do |item|
        if item_array[item.name].nil?
          item_array[item.name] = count_items(slot.id, item.id)
        else
          count = item_array[item.name] + count_items(slot.id, item.id)
          item_array[item.name] = count
        end
      end
    end 
    return item_array
  end 
end
