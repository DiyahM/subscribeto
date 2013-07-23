class Item < ActiveRecord::Base
  attr_accessible :price, :user_id, :name,
   :description
  belongs_to :user
  validates :price, :user_id, :name, presence: :true
  default_scope order('created_at DESC')
  
end
