class CreateCustomersAndDeliverySlots < ActiveRecord::Migration
  def change
    create_table :customers_delivery_slots do |t|
      t.integer :customer_id
      t.integer :delivery_slot_id
      t.belongs_to :customers
      t.belongs_to :delivery_slots
    end 
  end

end
