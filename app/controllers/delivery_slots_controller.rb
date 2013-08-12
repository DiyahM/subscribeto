class DeliverySlotsController < ApplicationController
  def index
    @deliveryslot = DeliverySlot.new
    @slots = current_user.delivery_slots
  end

  def create
    slot = current_user.delivery_slots.build(params[:delivery_slot])
    if slot.save
      flash[:notice] = "Delivery Route added"
    else
      flash[:error] = "Error in Creating Delivery Route. Please Try Again."
    end
    redirect_to user_delivery_slots_path(current_user)
  end

  def destroy
    slot = DeliverySlot.find(params[:id])
    slot.destroy

    redirect_to user_delivery_slots_path(current_user), :notice => "Delivery Time Removed"
  end

  def archive
    DeliverySlot.find(params[:id]).archive
    redirect_to user_delivery_slots_path(current_user)
  end
end
