class AddAaaToDeliveryDates < ActiveRecord::Migration
  def change
    add_column :delivery_dates, :archive_number, :string
    add_column :delivery_dates, :archived_at, :datetime
  end
end
