class PaymentDue < ActiveRecord::Base
  attr_accessible :amount, :due_date, :order_id, :paid
  belongs_to :order
  validates :order_id, presence: true
  after_create :set_values

  private

  def set_values
    self.amount = order.total
    self.paid = false
    case self.order.customer.term
    when "Net 30"
      self.due_date = self.order.complete_date + 30.day 
    when "Net 10"
      self.due_date = self.order.complete_date + 10.day
    when "Net 15"
      self.due_date = self.order.complete_date + 15.day
    when "Net 60"
      self.due_date = self.order.complete_date + 60.day
    end
    self.save
  end
end
