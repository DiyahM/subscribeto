class BillsController < ApplicationController
  
  def create
    @weekly_schedule = current_user.weekly_schedules.build(params[:weekly_schedule])
    if @weekly_schedule.save
      redirect_to root_path, notice: "Successfully created a Weekly Schedule"
    end
  end

  def update

  end

  def new
    week_start = Time.zone.today.beginning_of_week(:sunday)
    @weekly_schedule = WeeklySchedule.new_find_or_initialize_by(week_start, current_user.id)
  end

  def show

  end

end
