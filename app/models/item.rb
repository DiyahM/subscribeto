class Item < ActiveRecord::Base
  attr_accessible :price, :image_url, :user_id, :orders_count, :item_type, :spec_number, :name,
   :description, :pricing_unit
  belongs_to :user
  has_many :orders
end
