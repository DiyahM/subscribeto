class AddDeliveredToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :delivered, :boolean
  end
end
