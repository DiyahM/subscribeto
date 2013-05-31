class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def qb_customer_api
    if @qb_customer_api.nil?
      @qb_customer_api = Quickeebooks::Online::Service::Customer.new
      @qb_customer_api.access_token = qb_oauth_client
      @qb_customer_api.realm_id = current_user.qb_realm_id
    end
    return @qb_customer_api
  end  
  
  def qb_oauth_client
    @qb_oauth_client ||= OAuth::AccessToken.new($qb_oauth_consumer,
                                              current_user.qb_token,
                                              current_user.qb_secret)
    return @qb_oauth_client
  end

  helper_method :current_user, :qb_customer_api, :qb_oauth_client, :authorize 

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
end
