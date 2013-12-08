class Subscription < ActiveRecord::Base
  
  attr_accessible :stripe_created_at, :stripe_customer_id, 
                  :stripe_current_period_end, :stripe_current_period_start, :stripe_card_token
  
  attr_accessor :stripe_card_token
  
  belongs_to  :user

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: "#{self.user.email} is charged for monthly basic fee.", plan: "basic", card: stripe_card_token)
      self.stripe_customer_id = customer.id
      self.stripe_created_at = Date.strptime(customer.created.to_s,'%s')      
      self.payment_notes = customer.description
      self.stripe_current_period_start = Date.strptime(customer[:subscription][:current_period_start].to_s,'%s')
      self.stripe_current_period_end = Date.strptime(customer[:subscription][:current_period_end].to_s,'%s')
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
end
