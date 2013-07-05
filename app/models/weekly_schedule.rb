class WeeklySchedule < ActiveRecord::Base
  attr_accessible :user_id, :week_end, :week_start, :delivery_dates_attributes
  belongs_to :user
  has_many :delivery_dates
  validates :week_start, uniqueness: true
  accepts_nested_attributes_for :delivery_dates

  def self.find_or_initialize_by(week_start, user_id)
    schedule = WeeklySchedule.find_by_week_start_and_user_id(week_start, user_id)
    if schedule.nil?
      schedule = WeeklySchedule.new(week_start: week_start, user_id: user_id)
      ScheduleCreator.set_schedule(schedule)
    end
    return schedule
  end
end
