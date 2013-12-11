class SubscriptionsController < ApplicationController
  before_filter :authorize, except: [:stripe_callback]
  
  def new
    @subscription = current_user.subscriptions.new
  end


  def create
    @subscription = current_user.subscriptions.new(params[:subscription])
    if @subscription.save_with_payment
      redirect_to dashboard_path, :notice => "You have subscribed successfully! "
    else
      render :new
    end
  end

  def stripe_callback
    render json: "COool yo!", status: :ok
  end

end
