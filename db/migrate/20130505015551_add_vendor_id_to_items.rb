class AddVendorIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :vendor_id, :integer
  end
end
