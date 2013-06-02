class Categorization < ActiveRecord::Base
  attr_accessible :category_id, :item_id
  belongs_to :category
  belongs_to :item
end
