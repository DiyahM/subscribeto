class DeliverySlot < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  default_scope DeliverySlot.unarchived
  
  attr_accessible :day, :start_time, :user_id
  
  belongs_to :user
  
  has_and_belongs_to_many :customers
  
  has_many :delivery_dates, :dependent => :destroy
  
  validates :day, :start_time, :user_id, presence: true
  validates_inclusion_of :day, in: ['Sunday', 'Monday', 'Tuesday','Thursday','Friday','Saturday']


  def get_date_for(week_start)
    case day
    when "Sunday"
      ret_date = week_start
    when "Monday"
      ret_date = week_start + 1.day
    when "Tuesday"
      ret_date = week_start + 2.days
    when "Wednesday"
      ret_date = week_start + 3.days
    when "Thursday"
      ret_date = week_start + 4.days
    when "Friday"
      ret_date = week_start + 5.days
    when "Saturday"
      ret_date = week_start + 6.days
    end
    
    return ret_date
  end

  def delivery_label
    day + start_time.strftime("%l:%M %p")
  end

  def self.delivery_schedule_for_day(day_of_week, id)
    DeliverySlot.where("day = ? AND user_id = ? ", day_of_week, id).includes(:undelivered_items) 
  end

  def self.daily_summary(day_of_week, id)
    item_array = {}
    todays_slots = DeliverySlot.delivery_schedule_for_day(day_of_week, id)
    todays_slots.each do |slot|
      slot.items.each do |item|
        count = count_items(slot.id, item.id)
        if item_array[item.name].nil?
          item_array[item.name] = count if (count > 0)
        else
          total = item_array[item.name] + count
          item_array[item.name] = total
        end
      end
    end 
    return item_array
  end 
end
