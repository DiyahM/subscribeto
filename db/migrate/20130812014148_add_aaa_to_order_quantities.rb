class AddAaaToOrderQuantities < ActiveRecord::Migration
  def change
    add_column :order_quantities, :archive_number, :string
    add_column :order_quantities, :archived_at, :datetime
  end
end
