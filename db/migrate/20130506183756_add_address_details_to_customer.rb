class AddAddressDetailsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :address_one, :string
    add_column :customers, :address_two, :string
    add_column :customers, :city, :string
    add_column :customers, :state, :string
    add_column :customers, :postal_code, :string
  end
end
