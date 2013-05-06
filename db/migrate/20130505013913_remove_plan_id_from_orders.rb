class RemovePlanIdFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :plan_id
  end

  def down
    add_column :orders, :plan_id, :string
  end
end
