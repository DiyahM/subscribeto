class Order < ActiveRecord::Base
  attr_accessible :user_id, :customer_attributes, :item_id, :payment_due_attributes, :start_date
  has_one :customer
  belongs_to :item, counter_cache: true
  belongs_to :user
  has_many :payment_recvd
  has_many :payment_due
  accepts_nested_attributes_for :customer, :payment_due
  after_create :create_payment_due
  scope :new_orders, lambda { where("created_at > ?", Time.zone.now - 1.month ) }
  

  def self.past_due
    orders = []
    Order.includes(:payment_due).all.each do |order|
      if order.delinquent?
        orders << order
      end
    end
    return orders
  end

  def delinquent?
    if self.payment_due.last.due_date < Time.zone.now
      if !self.payment_due.last.paid
        return true
      end
    end
    return false
  end  

  def self.upcoming
    orders = []
     Order.includes(:payment_due).all.each do |order|
      if order.soon_due?
        orders << order
      end
    end
    return orders
  end

  def soon_due?
    days = (self.payment_due.last.due_date - Time.zone.now)/1.day
    if days < 30
      return true
    end
    return false
  end

  def create_payment_due
    bill = PaymentDue.new
    bill.amount = self.item.price

    #set billing cycle start date
    if self.item.service_start == "on order date"
      bill.bill_cycle_start = self.start_date
    else
      bill.bill_cycle_start = self.start_date + 1.month
      if self.item.bill_cycle_start == "first day of month"
        bill.bill_cycle_start = bill.bill_cycle_start.change(day:1)
      elsif self.item.bill_cycle_start == "15th day of month"
        bill.bill_cycle_start = bill.bill_cycle_start.change(day:15)
      end
    end

    #set billing cycle end date
    bill.bill_cycle_end = bill.bill_cycle_start + 1.month
    if self.item.bill_cycle_start == "first day of month"
      bill.bill_cycle_end = bill.bill_cycle_end.change(day:1) - 1.day
    elsif self.item.bill_cycle_start == "15th day of month"
      bill.bill_cycle_end = bill_cycle_end.change(day:15) - 1.day
    elsif self.item.bill_cycle_start == "monthly from date ordered"
      bill.bill_cycle_end -= 1.day
    end

    #set payment date
    if self.item.bill_cycle_type == "in advance to services"
      bill.due_date = self.created_at + self.item.payment_due.day
    else
      bill.due_date = bill.bill_cycle_end + self.item.payment_due.day
    end 

    #set payment amount
    days = (bill.bill_cycle_end - bill.bill_cycle_start)/1.day
    if days > 27
      bill.amount = self.item.price
    else
      bill.amount = days * (self.item.price/30)
    end
    
    
    bill.save!
    self.payment_due << bill
  end  
end
