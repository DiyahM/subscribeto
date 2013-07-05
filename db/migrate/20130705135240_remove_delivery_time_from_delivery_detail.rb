class RemoveDeliveryTimeFromDeliveryDetail < ActiveRecord::Migration
  def up
    remove_column :delivery_details, :delivery_time
  end

  def down
    add_column :delivery_details, :delivery_time, :string
  end
end
