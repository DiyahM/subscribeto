class Customer < ActiveRecord::Base
  attr_accessible :email, :phone_number, :address_one, :address_two, :city, :state, :postal_code,
    :company_name, :poc_name, :user_id, :note, :term, :delivery_slot_ids
  belongs_to :user
  has_and_belongs_to_many :delivery_slots
  has_many :orders
  has_many :payment_dues, through: :orders
  has_many :delivery_details
  has_many :delivery_dates, through: :delivery_details
end
