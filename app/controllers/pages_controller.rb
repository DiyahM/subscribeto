class PagesController < ApplicationController
  before_filter :authorize, :except => [:home]

  def home
    @layout = "home"
  end

  def mark_delivered
    LineItem.mark_batch_delivered(params[:ids])
    render :nothing => true
  end

  def dashboard
    if session[:first_login]
      @first_login = true
    end
    
    week_start = Date.current.beginning_of_week(:sunday)

    if !params[:datepicker].nil?
      begin
        week_start = Date.strptime(params[:datepicker], '%m/%d/%Y').beginning_of_week(:sunday)
      rescue
        flash[:error]= "Invalid Date"
      end
    end
    
    @weekly_schedule = WeeklySchedule.find_or_initialize_by(week_start, current_user.id)
  end
end
