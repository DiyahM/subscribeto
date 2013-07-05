class DeliveryDate < ActiveRecord::Base
  attr_accessible :scheduled_for, :weekly_schedule_id, :delivery_details_attributes, :delivery_slot_id
  has_many :delivery_details
  has_many :customers, through: :delivery_details
  belongs_to :delivery_slot
  accepts_nested_attributes_for :delivery_details
end
