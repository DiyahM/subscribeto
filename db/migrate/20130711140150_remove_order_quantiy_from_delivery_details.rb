class RemoveOrderQuantiyFromDeliveryDetails < ActiveRecord::Migration
  def up
    remove_column :delivery_details, :item_id
    remove_column :delivery_details, :qty_ordered
  end

  def down
    add_column :delivery_details, :qty_ordered, :string
    add_column :delivery_details, :item_id, :string
  end
end
