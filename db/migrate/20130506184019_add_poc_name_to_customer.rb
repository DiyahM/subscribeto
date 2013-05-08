class AddPocNameToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :poc_name, :string
  end
end
