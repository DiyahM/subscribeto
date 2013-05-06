class Ingredient < ActiveRecord::Base
  attr_accessible :prepared_id, :quantity, :raw_id
  belongs_to :raw
  belongs_to :prepared
end
