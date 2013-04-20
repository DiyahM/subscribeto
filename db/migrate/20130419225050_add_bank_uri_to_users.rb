class AddBankUriToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bank_uri, :string
  end
end
