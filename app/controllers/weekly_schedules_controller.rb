class WeeklySchedulesController < ApplicationController
  def create
    @weekly_schedule = current_user.weekly_schedules.create(params[:weekly_schedule])
    if @weekly_schedule.errors.messages.empty?
      @show_invoice = true
      render "pages/dashboard", notice: "Weekly Schedule has been saved"
    else
      render "pages/dashboard", error: "Unable to save schedule"  
    end 
  end

  def update
    puts "*****UPDATE"
  end
end
