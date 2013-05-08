class User < ActiveRecord::Base
  has_secure_password
  has_many :delivery_slots, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_one :site
  has_many :orders, :dependent => :destroy
  has_many :customers, :dependent => :destroy
  has_many :payment_dues, through: :orders
  attr_accessible :name, :email, :password, :password_confirmation, :account_type, :phone_number, 
    :tax_id, :dob, :city, :postal_code, :street_address
  validates :email, presence: true
  validates :password, :password_confirmation, presence: true, if: :validate_password?
  validates :email, uniqueness: true

  def validate_password?
    password.present? || password_confirmation.present?
  end
  attr_writer :current_step
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[initial merchant_data]
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
