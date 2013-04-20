class Plan < ActiveRecord::Base
  attr_accessible :frequency, :image_url, :plan_code, :plan_description, :plan_name, :price
  belongs_to :user
end
