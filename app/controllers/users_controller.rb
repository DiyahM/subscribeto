class UsersController < ApplicationController
  before_filter :authorize, :only => [:edit, :update]
  def new
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to  edit_user_path(current_user), notice: "Thank you for signing up. Get started by completing your profile" 
    else
      render "new"
    end
  end

  def edit
  end

  def update
    current_user.update_attributes!(params[:user]) 
    redirect_to dashboard_path, notice: "Your account profile has been updated"    
  end

end
