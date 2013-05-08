class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :delivery_slot_id
      t.integer :quantity

      t.timestamps
    end
  end
end
