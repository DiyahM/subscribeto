class Item < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  default_scope Item.unarchived.order('created_at DESC')
  attr_accessible :price, :user_id, :name,
   :description
  belongs_to :user
  validates :price, :user_id, :name, presence: :true
  
end
