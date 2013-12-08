class WeeklySchedulesController < ApplicationController
  before_filter :authorize
  before_filter :verify_subscription
  def create
    @weekly_schedule = current_user.weekly_schedules.build(params[:weekly_schedule])
    if @weekly_schedule.save
      @show_invoice = true
      @weekly_schedule = WeeklySchedule.find_or_initialize_by(@weekly_schedule.week_start, current_user.id)
      render "pages/dashboard", notice: "Weekly Schedule has been saved"
    else
      render "pages/dashboard", error: "Unable to save schedule"  
    end 
  end

  def update
    @weekly_schedule = WeeklySchedule.find(params[:id])
    @weekly_schedule.update_attributes(params[:weekly_schedule])
    if @weekly_schedule.errors.messages.empty?
      @weekly_schedule = WeeklySchedule.find_or_initialize_by(@weekly_schedule.week_start, current_user.id)
      @show_invoice = true
      render "pages/dashboard", notice: "Weekly Schedule has been saved"
    else
      render "pages/dashboard", error: "Unable to save schedule"
    end
  end
end
