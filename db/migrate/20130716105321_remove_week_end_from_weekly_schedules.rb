class RemoveWeekEndFromWeeklySchedules < ActiveRecord::Migration
  def up
    remove_column :weekly_schedules, :week_end
  end

  def down
    add_column :weekly_schedules, :week_end, :datetime
  end
end
