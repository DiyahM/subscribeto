class OrderTemplate < ActiveRecord::Base
  attr_accessible :order_id, :user_id
  belongs_to :order
  belongs_to :user
end
