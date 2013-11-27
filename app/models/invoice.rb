class Invoice < ActiveRecord::Base
  acts_as_archival :readonly_when_archived => true
  # default_scope Invoice.unarchived.includes(:customer, :order_items)
  
  attr_accessible :customer_id, :user_id, :weekly_schedule_id, :memo, :invoice_number, :due_date, :amount_due, :order_items_attributes, :complete_due_date, :amount_due, :state
  
  belongs_to :customer
  belongs_to :user
  belongs_to :weekly_schedule

  has_many :bills
  has_many :order_items
  
  after_initialize :default_values
  
  validates_uniqueness_of :invoice_number, scope: :user_id
  validates_presence_of :customer_id, message: "can't be blank"
  validates_presence_of :complete_due_date, message: "can't be blank"

  accepts_nested_attributes_for :order_items, :allow_destroy => true, reject_if: lambda { |a| a[:quantity].to_i < 1 and a[:qty_delivered].to_i < 1 and a[:qty_returned].to_i < 1 }

  before_create :generate_invoice_number, unless: Proc.new { |invoice| invoice.invoice_number.present? }
  before_create :add_default_state
  before_destroy :validate_state
  before_save :delete_zero_delivered_items

  scope :drafted, -> { where(state: DRAFT) }
  scope :finalized, -> { where(state: FINAL) }

  DRAFT     =   "draft"
  FINAL     =   "final"

  STATES    = [DRAFT, FINAL]

  def can_be_editted?
    self.state.eql?(DRAFT) ? true : false
  end

  def validate_state
    return false unless self.state?(DRAFT)
  end

  def state?(state)
    my_state = self.state
    case state
    when DRAFT
      my_state.eql?(DRAFT)
    when FINAL
      my_state .eql?(FINAL)
    else
      false
    end
  end

  def add_default_state
    self.state = DRAFT unless self.state.present?
  end

  def complete_due_date
    due_date.strftime("%m/%d/%Y") if due_date
  end

  def complete_due_date=(value)
    self.due_date = Date.strptime(value, '%m/%d/%Y') if value.present?
  end

  def build_order_items
    self.user.items.each do |item|
      unless self.order_items.map(&:item_id).include?(item.id)
        self.order_items.build(item_id: item.id,
                                  price_charged: item.price,
                                  quantity: 0,
                                  qty_delivered: 0,
                                  qty_returned: 0
                                )
      end
    end

  end

  def default_values
    if new_record?
      self.memo = "Thank you for your business!" if self.memo.nil?
      self.due_date = self.due_date_with_terms if self.due_date.nil? and !self.customer.nil?
      self.save
    end
  end

  def invoice_date_iif
    created_at.strftime("%m/%d/%y")
  end

  # def order_items
  #   delivery_details.flat_map{|n| n.order_items }.find_all{|n| n.quantity>0}
  # end

  def amount_due
    total = 0
    order_items.each do |order_item|  
      total += order_item.subtotal
    end
    return total
  end

  def amount_due_iif
    0 - amount_due
  end

  def formatted_due_date

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

  def generate_invoice_number
    invoice = self.user.invoices.order("id").last
    if !invoice.nil?
      num = invoice.invoice_number + 1
    else
      num = 1000
    end
    self.invoice_number = num
  end

  def due_date_with_terms

    the_due_date = Time.now
    if customer.term == "Due upon receipt"
      the_due_date = self.bill.scheduled_for 
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
    the_due_date
  end
  
  def delete_zero_delivered_items
    self.order_items.each do |item|
      item.delete if item.qty_delivered < 1
    end
  end

end
