class AddTermToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :term, :string
  end
end
