class CreateOrderQuantities < ActiveRecord::Migration
  def change
    create_table :order_quantities do |t|
      t.integer :item_id
      t.integer :quantity, default: 0
      t.integer :delivery_detail_id

      t.timestamps
    end
  end
end
