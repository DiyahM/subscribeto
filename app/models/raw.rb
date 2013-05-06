class Raw < Item
  attr_accessible :vendor_attributes, :vendor_name 
  belongs_to :vendor
  accepts_nested_attributes_for :vendor
  attr_accessor :vendor_name

  has_many :ingredients
  has_many :prepared, :through => :ingredients
end
