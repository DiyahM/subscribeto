class AddItemToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :item_id, :integer
  end
end
