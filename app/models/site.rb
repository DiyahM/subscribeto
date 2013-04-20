class Site < ActiveRecord::Base
  attr_accessible :company_name, :description, :facebook, :headline, :logo, :twitter, :website_url
  belongs_to :user
end
