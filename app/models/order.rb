class Order < ActiveRecord::Base
  attr_accessible :user_id, :customer_attributes, :plan_id
  has_one :customer
  belongs_to :plan
  belongs_to :user
  accepts_nested_attributes_for :customer
end
