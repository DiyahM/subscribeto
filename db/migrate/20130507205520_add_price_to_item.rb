class AddPriceToItem < ActiveRecord::Migration
  def change
    add_column :items, :price, :decimal, precision: 8, scale: 2, default: 0
  end
end
