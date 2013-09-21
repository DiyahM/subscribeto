class AddAaaToDeliverySlots < ActiveRecord::Migration
  def change
    add_column :delivery_slots, :archive_number, :string
    add_column :delivery_slots, :archived_at, :datetime
  end
end
