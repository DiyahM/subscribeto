class CreateWeeklySchedules < ActiveRecord::Migration
  def change
    create_table :weekly_schedules do |t|
      t.integer :user_id
      t.datetime :week_start
      t.datetime :week_end

      t.timestamps
    end
  end
end
