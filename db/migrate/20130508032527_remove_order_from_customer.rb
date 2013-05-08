class RemoveOrderFromCustomer < ActiveRecord::Migration
  def up
    remove_column :customers, :order_id
  end

  def down
    add_column :customers, :order_id, :string
  end
end
