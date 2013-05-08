class RemovePriceFromItem < ActiveRecord::Migration
  def up
    remove_column :items, :price
  end

  def down
    add_column :items, :price, :string
  end
end
