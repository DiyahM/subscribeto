class User < ActiveRecord::Base
  has_secure_password
  has_many :delivery_slots, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :customers, :dependent => :destroy
  has_many :payment_dues, through: :orders
  attr_accessible :company_name, :name, :email, :password, :password_confirmation, :account_type, :phone_number, 
    :tax_id, :dob, :city, :postal_code, :street_address, :state, :qb_token, :qb_secret, :qb_realm_id
  validates :email, presence: true
  validates :password, :password_confirmation, presence: true
  validates :email, uniqueness: true

end
