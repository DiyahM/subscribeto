class Prepared < Item
  attr_accessible :raw_tokens, :ingredients_attributes
  has_many :ingredients
  has_many :raws, :through => :ingredients  
  accepts_nested_attributes_for :ingredients, :reject_if => :all_blank, :allow_destroy => true
  attr_reader :raw_tokens
  
  def raw_tokens=(ids)
    self.raw_ids = ids.split(",")
  end
end
