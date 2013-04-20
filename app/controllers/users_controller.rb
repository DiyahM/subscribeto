class UsersController < ApplicationController
  def new
    session[:user_params] ||= {}
    @user = User.new(session[:user_params])
    @user.current_step = session[:user_step]
  end

  def create
    session[:user_params].deep_merge!(params[:user]) if params[:user]
    @user = User.new(session[:user_params])
    @user.current_step = session[:user_step]
    if params[:back_button]
      @user.previous_step
    elsif @user.last_step?
      if @user.all_valid?
        @user.save
        payments_service.create_seller(@user.id)
        session[:user_id] = @user.id
      end
    else
      @user.next_step
    end
    session[:user_step] = @user.current_step
    if @user.new_record?
      render "new"
    else
      session[:user_step] = session[:user_params] = nil
      flash[:notice] = "Thank you for signing up"
      redirect_to pages_banking_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def add_bank_account
    puts "Add bank_account"
    #payments_service.add_bank_account(current_user.id, params[:bank_uri]) 
    #redirect_to user_plans_path(current_user)
  end
end
