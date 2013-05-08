class Customer < ActiveRecord::Base
  attr_accessible :email, :phone_number, :address_one, :address_two, :city, :state, :postal_code,
    :company_name, :poc_name, :user_id
  belongs_to :user
  has_many :orders, :dependent => :destroy
end
