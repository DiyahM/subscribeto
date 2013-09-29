class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      
      t.belongs_to :weekly_schedule
      t.belongs_to :delivery_slot
      t.belongs_to :customer
      t.belongs_to :invoice
      t.belongs_to :user

      t.date       :scheduled_for

      t.timestamps
    end
  end
end
