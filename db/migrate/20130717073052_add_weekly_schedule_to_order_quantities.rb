class AddWeeklyScheduleToOrderQuantities < ActiveRecord::Migration
  def change
    add_column :order_quantities, :weekly_schedule_id, :integer
  end
end
