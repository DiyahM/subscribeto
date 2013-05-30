class Item < ActiveRecord::Base
  attr_accessible :price, :image_url, :user_id, :orders_count, :item_type, :spec_number, :name,
   :description, :pricing_unit
  belongs_to :user
  has_many :orders
  validates :item_type, presence: :true

  def self.prepared_goods(id)
    Item.where("item_type = ? AND user_id = ?", "Available for sale", id).order("updated_at DESC")
  end
end
