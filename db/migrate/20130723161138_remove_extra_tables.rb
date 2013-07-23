class RemoveExtraTables < ActiveRecord::Migration
  def up
    drop_table :categories
    drop_table :categorizations
    drop_table :line_items
    drop_table :order_templates
    drop_table :order_weeks
    drop_table :orders
    drop_table :payment_dues
    drop_table :profiles
  end

  def down
  end
end
