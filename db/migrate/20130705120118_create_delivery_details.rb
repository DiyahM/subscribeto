class CreateDeliveryDetails < ActiveRecord::Migration
  def change
    create_table :delivery_details do |t|
      t.integer :customer_id
      t.integer :weekly_schedule_id
      t.integer :item_id
      t.datetime :delivery_time
      t.integer :qty_ordered

      t.timestamps
    end
  end
end
