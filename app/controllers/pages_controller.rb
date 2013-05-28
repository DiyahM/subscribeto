class PagesController < ApplicationController
  def home
    @layout = "home"
  end

  def banking
  end

  def quickstart

  end
  
  def mark_delivered
    LineItem.mark_batch_delivered(params[:ids])
    render :nothing => true
  end

  def dashboard
    if params[:datepicker].nil?
      date = Date.current
    else
      begin
        date = Date.strptime(params[:datepicker], '%m/%d/%Y')
      rescue
        date = Date.current
        flash[:error]= "Invalid Date"
      end
    end
    @date = date.strftime("%A, %b %e")
    day = date.strftime("%A")
    @item_summary= DeliverySlot.daily_summary(day, current_user.id)
    @slots = DeliverySlot.delivery_schedule_for_day(day, current_user.id)    
    @uninvoiced_items = current_user.orders.delivered
  end
end
