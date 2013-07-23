class Item < ActiveRecord::Base
  attr_accessible :price, :image_url, :user_id, :orders_count, :item_type, :spec_number, :name,
   :description, :pricing_unit, :category_ids
  belongs_to :user
  has_many :orders
  has_many :categorizations
  has_many :categories, through: :categorizations
  validates :price, :user_id, :name, presence: :true
  default_scope order('created_at DESC')

  def self.prepared_goods(id)
    Item.where("item_type = ? AND user_id = ?", "Available for sale", id).order("updated_at DESC")
  end
end
