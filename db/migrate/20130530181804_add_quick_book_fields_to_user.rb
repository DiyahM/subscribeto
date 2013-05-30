class AddQuickBookFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :qb_token, :string
    add_column :users, :qb_secret, :string
    add_column :users, :qb_realm_id, :string
  end
end
