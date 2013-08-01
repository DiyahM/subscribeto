class Invoice < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  default_scope Invoice.unarchived.includes(:customer, delivery_details: [order_quantities: :item])
  attr_accessible :customer_id, :user_id, :weekly_schedule_id, :memo
  belongs_to :customer
  belongs_to :user
  belongs_to :weekly_schedule
  has_many :delivery_details
  after_initialize :default_values

  def default_values
    if new_record?
      self.memo = "Thank you for your business!"
      self.save
    end
  end

  def order_quantities
    delivery_details.flat_map{|n| n.order_quantities }.find_all{|n| n.quantity>0}
  end

  def amount_due
    total = 0
    delivery_details.each do |delivery_detail|
      delivery_detail.order_quantities.each do |order|
        total += order.subtotal
      end
    end
    return total
  end

  def due_date

    the_due_date = created_at
    if customer.term == "Due upon receipt"
      return customer.term
    else
      case customer.term
      when "Net 30"
        the_due_date += 30.day
      when "Net 7"
        the_due_date += 7.day
      when "Net 10"
        the_due_date += 10.day
      when "Net 15"
        the_due_date += 15.day
      when "Net 60"
        the_due_date += 60.day
      end
    end
    return the_due_date.strftime("%B %d, %Y")
  end
  
end
