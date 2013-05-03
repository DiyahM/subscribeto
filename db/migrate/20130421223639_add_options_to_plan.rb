class AddOptionsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :service_start, :string
    add_column :plans, :bill_cycle_start, :string
    add_column :plans, :bill_cycle_type, :string
  end
end
