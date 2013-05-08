class AddUserToDeliverySlot < ActiveRecord::Migration
  def change
    add_column :delivery_slots, :user_id, :integer
  end
end
