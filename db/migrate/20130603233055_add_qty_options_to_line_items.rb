class AddQtyOptionsToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :qty_delivered, :integer, :default => 0
    add_column :line_items, :qty_returned, :integer, :default => 0
  end
end
