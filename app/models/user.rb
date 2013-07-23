class User < ActiveRecord::Base
  has_secure_password
  has_many :delivery_slots, :dependent => :destroy
  has_many :items, :dependent => :destroy, :order => ('created_at DESC')
  has_many :customers, :dependent => :destroy
  has_many :weekly_schedules
  attr_accessible :company_name, :name, :email, :password, :password_confirmation, :account_type, :phone_number, 
    :tax_id, :dob, :city, :postal_code, :street_address, :state, :qb_token, :qb_secret, :qb_realm_id,
    :quickbooks_desktop
  validates :email, presence: true
  validates :password, :password_confirmation, presence: true, if: :validate_password?
  validates :email, uniqueness: true
  
  def validate_password?
    password.present? || password_confirmation.present?
  end
  
end
