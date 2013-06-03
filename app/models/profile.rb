class Profile < ActiveRecord::Base
  attr_accessible :about, :address, :certifications, :phone_number, :web, :user_id, :image_url

  belongs_to :user

  after_create :default_values

  private

    def default_values
      self.image_url = "http://placehold.it/300x300&text=[Add%20Profile%20Image]"
      self.about = "Use this section to talk about your company."
      self.certifications= "Add any certifications here."
      self.save!
    end
end
