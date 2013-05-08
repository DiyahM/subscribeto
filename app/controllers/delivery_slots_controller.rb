class DeliverySlotsController < ApplicationController
  def index
    @deliveryslot = DeliverySlot.new
    @slots = current_user.delivery_slots
  end

  def create
    slot = current_user.delivery_slots.build(params[:delivery_slot])
    if slot.save
      notice = "Delivery Slot added"
    else
      notice = "Could not create Delivery Slot"
    end
    redirect_to user_delivery_slots_path(current_user), :notice => notice
  end

  def destroy
    slot = DeliverySlot.find(params[:id])
    slot.destroy

    redirect_to user_delivery_slots_path(current_user), :notice => "Delivery Time Removed"
  end
end
