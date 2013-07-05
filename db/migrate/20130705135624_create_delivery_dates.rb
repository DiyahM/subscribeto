class CreateDeliveryDates < ActiveRecord::Migration
  def change
    create_table :delivery_dates do |t|
      t.datetime :scheduled_for
      t.integer :weekly_schedule_id

      t.timestamps
    end
  end
end
