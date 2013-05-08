class PagesController < ApplicationController
  def home
    @layout = "home"
  end

  def banking
  end

  def quickstart

  end
  def dashboard
    day = Time.now.strftime("%A")
    @summary = DeliverySlot.items_count_by_day(day, current_user.id)
    @todays_orders = DeliverySlot.orders_by_day(day, current_user.id)    
  end
end
