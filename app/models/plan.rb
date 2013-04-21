class Plan < ActiveRecord::Base
  attr_accessible :frequency, :image_url, :plan_code, :plan_description, :plan_name, :price, :user_id
  belongs_to :user
  has_many :orders
end
