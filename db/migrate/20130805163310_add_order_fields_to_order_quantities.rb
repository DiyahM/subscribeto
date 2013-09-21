class AddOrderFieldsToOrderQuantities < ActiveRecord::Migration
  def change
    add_column :order_quantities, :qty_delivered, :integer, :default => 0
    add_column :order_quantities, :qty_returned, :integer, :default => 0
  end
end
