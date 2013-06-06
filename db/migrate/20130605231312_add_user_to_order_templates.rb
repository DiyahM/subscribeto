class AddUserToOrderTemplates < ActiveRecord::Migration
  def change
    add_column :order_templates, :user_id, :integer
  end
end
