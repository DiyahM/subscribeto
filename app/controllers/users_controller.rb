class UsersController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up"
      redirect_to dashboard_path
    else
      render "new"
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
