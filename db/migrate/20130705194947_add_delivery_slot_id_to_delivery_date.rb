class AddDeliverySlotIdToDeliveryDate < ActiveRecord::Migration
  def change
    add_column :delivery_dates, :delivery_slot_id, :integer
  end
end
