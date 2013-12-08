class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table    :subscriptions do |t|
      t.string      :stripe_customer_id
      t.string      :stripe_current_period_start
      t.string      :stripe_current_period_end
      t.string      :stripe_created_at
      t.string      :payment_notes
      t.belongs_to  :user
      t.timestamps
    end
  end
end
