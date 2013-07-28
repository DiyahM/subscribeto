class AddAaaToDeliveryDetails < ActiveRecord::Migration
  def change
    add_column :delivery_details, :archive_number, :string
    add_column :delivery_details, :archived_at, :datetime
  end
end
