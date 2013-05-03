class AddCounterCacheToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :orders_count, :integer, default: 0

    Plan.find_each do |plan|
      plan.update_attribute(:orders_count, plan.orders.length)
      plan.save
    end
  end
end
