class RemoveNamesFromCustomer < ActiveRecord::Migration
  def up
    remove_column :customers, :first_name
    remove_column :customers, :last_name
  end

  def down
    add_column :customers, :last_name, :string
    add_column :customers, :first_name, :string
  end
end
