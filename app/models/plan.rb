class Plan < ActiveRecord::Base
  attr_accessible :frequency, :image_url, :plan_code, :plan_description, :plan_name, :price, :user_id,
    :service_start, :bill_cycle_start, :bill_cycle_type, :payment_due
  belongs_to :user
  has_many :orders

  def self.revenue
    revenue = 0
    Plan.all.each do |plan|
      revenue += plan.orders_count * plan.price
    end
    return revenue
  end
end
