class AddOrderIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :order_id, :integer
  end
end
