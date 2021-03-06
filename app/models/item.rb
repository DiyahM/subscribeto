class Item < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  default_scope Item.unarchived.order('id DESC')
  
  attr_accessible :price, :user_id, :name, :description
  
  belongs_to :user
  
  has_many :order_items, :dependent => :destroy 
  
  validates :price, :user_id, :name, presence: :true
  validates_uniqueness_of :name, scope: :user_id
  
end
