class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :user_id
      t.integer :weekly_schedule_id

      t.timestamps
    end
  end
end
