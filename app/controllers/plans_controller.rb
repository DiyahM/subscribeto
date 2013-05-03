class PlansController < ApplicationController
  def index
    @plans = current_user.plans
  end

  def show
    @plan = Plan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
    end
  end

  def new
    @plan = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def create
    @plan = Plan.new(params[:plan])

    respond_to do |format|
      if @plan.save
        current_user.plans << @plan
        format.html { redirect_to user_plans_path, notice: 'Plan was successfully created.' }
        format.json { render json: @plan, status: :created, location: @plan }
      else
        format.html { render action: "new" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @plan = Plan.find(params[:id])

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        format.html { redirect_to user_plan_path(current_user, @plan), notice: 'Plan was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to plans_url }
      format.json { head :no_content }
    end
  end
end
