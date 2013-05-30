class RemoveUnnecessaryTables < ActiveRecord::Migration
  def up
    drop_table :ingredients
    drop_table :payment_recvds
    drop_table :sites
    drop_table :vendors
  end

  def down
  end
end
