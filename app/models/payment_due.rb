class PaymentDue < ActiveRecord::Base
  attr_accessible :amount, :due_date, :order_id, :paid
  belongs_to :order
  validates :order_id, presence: true
  after_create :set_values

  def status
    paid? ? "Paid" : "Unpaid"
  end

  def print_due_date
    if order.customer.term == "Due upon receipt"
      return "Due upon receipt"
    else
      return due_date.strftime("%B %d, %Y")
    end
  end

  private

  def set_values
    self.amount = order.total
    self.paid = false
    case self.order.customer.term
    when "Net 30"
      self.due_date = self.created_at + 30.day 
    when "Net 7"
      self.due_date = self.created_at + 7.day
    when "Net 10"
      self.due_date = self.created_at + 10.day
    when "Net 15"
      self.due_date = self.created_at + 15.day
    when "Net 60"
      self.due_date = self.created_at + 60.day
    end
    self.save
  end
end
