class UsersController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up"
      redirect_to quickstart_path
    else
      render "new"
    end
  end

  def edit
    redirect_to :back, notice: "Unauthorized to view page" unless current_user
  end

  def update
    current_user.update_attributes(params[:user]) if current_user
    redirect_to dashboard_path, notice: "Settings Updated"    
  end

  def add_bank_account
    puts "Add bank_account"
    #payments_service.add_bank_account(current_user.id, params[:bank_uri]) 
    #redirect_to user_plans_path(current_user)
  end
end
