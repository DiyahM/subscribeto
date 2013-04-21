class Customer < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :phone_number, :order_id
  belongs_to :order
end
