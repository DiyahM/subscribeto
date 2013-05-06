class Vendor < ActiveRecord::Base
  attr_accessible :address, :contact_name, :email, :name, :notes, :phone
  has_many :items
end
