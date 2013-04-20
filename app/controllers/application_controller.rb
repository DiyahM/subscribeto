class ApplicationController < ActionController::Base
  protect_from_forgery

  

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def payments_service 
    @payments_service ||= PaymentsService.new
  end
  
  helper_method :current_user, :payments_service
end
