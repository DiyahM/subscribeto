class AddPriceChargedToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :price_charged, :integer
    add_column :order_items, :bill_id, :integer
  end
end
