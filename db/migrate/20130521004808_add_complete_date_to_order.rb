class AddCompleteDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :complete_date, :date
  end
end
