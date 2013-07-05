class AddDeliveryDateIdToDeliveryDetail < ActiveRecord::Migration
  def change
    add_column :delivery_details, :delivery_date_id, :integer
  end
end
