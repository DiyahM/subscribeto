class CreateOrderTemplates < ActiveRecord::Migration
  def change
    create_table :order_templates do |t|
      t.integer :order_id

      t.timestamps
    end
  end
end
