class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :email, :password, :password_confirmation, :account_type, :phone_number, 
    :tax_id, :dob, :city, :postal_code, :street_address
  validates :name, :email, :password, :password_confirmation, :account_type, :phone_number, 
    :postal_code, :street_address, presence: true
  validates :email, uniqueness: true

  attr_writer :current_step
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[initial type merchant_data]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
