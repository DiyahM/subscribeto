class RenameOrderQuantitiesToOrder < ActiveRecord::Migration
  def up
    rename_table :order_quantities, :order_items
  end

  def down
    rename_table :order_items, :order_quantities
  end
end
