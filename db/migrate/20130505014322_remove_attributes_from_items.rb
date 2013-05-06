class RemoveAttributesFromItems < ActiveRecord::Migration
  def up
    remove_column :items, :plan_code
    remove_column :items, :plan_name
    remove_column :items, :plan_description
    remove_column :items, :frequency
    remove_column :items, :service_start
    remove_column :items, :bill_cycle_start
    remove_column :items, :bill_cycle_type
    remove_column :items, :payment_due
  end

  def down
    add_column :items, :payment_due, :string
    add_column :items, :bill_cycle_type, :string
    add_column :items, :bill_cycle_start, :string
    add_column :items, :service_start, :string
    add_column :items, :frequency, :string
    add_column :items, :plan_description, :string
    add_column :items, :plan_name, :string
    add_column :items, :plan_code, :string
  end
end
