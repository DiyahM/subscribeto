class AddPlanIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :plan_id, :integer
  end
end
