class AddMerchantDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :account_type, :string
    add_column :users, :phone_number, :string
    add_column :users, :tax_id, :string
    add_column :users, :dob, :string
    add_column :users, :city, :string
    add_column :users, :postal_code, :string
    add_column :users, :street_address, :string
  end
end
