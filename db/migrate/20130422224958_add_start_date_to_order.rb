class AddStartDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :start_date, :datetime
  end
end
