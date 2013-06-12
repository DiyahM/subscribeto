class AddQuickbooksDesktopToUser < ActiveRecord::Migration
  def change
    add_column :users, :quickbooks_desktop, :boolean
  end
end
