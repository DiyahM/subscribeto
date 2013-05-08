class CreateDeliverySlots < ActiveRecord::Migration
  def change
    create_table :delivery_slots do |t|
      t.string :day
      t.time :start_time

      t.timestamps
    end
  end
end
