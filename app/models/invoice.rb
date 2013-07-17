class Invoice < ActiveRecord::Base
  attr_accessible :customer_id, :user_id, :weekly_schedule_id, :memo
  belongs_to :customer
  belongs_to :user
  belongs_to :weekly_schedule
  has_many :delivery_details
  after_initialize :default_values

  def default_values
    self.memo = "Thank you for your business!"
    self.save
  end

  def amount_due
    total = 0
    delivery_details.each do |delivery_detail|
      delivery_detail.order_quantities.each do |order|
        total += order.subtotal
      end
    end
    return total
  end
  
end
