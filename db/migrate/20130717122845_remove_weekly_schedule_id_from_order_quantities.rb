class RemoveWeeklyScheduleIdFromOrderQuantities < ActiveRecord::Migration
  def up
    remove_column :order_quantities, :weekly_schedule_id
  end

  def down
    add_column :order_quantities, :weekly_schedule_id, :string
  end
end
