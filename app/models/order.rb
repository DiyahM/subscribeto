class Order < ActiveRecord::Base
  attr_accessible :user_id, :customer_attributes, :item_id, :payment_due_attributes, :start_date,
    :customer_company, :line_items_attributes, :customer_id, :status
  belongs_to :customer
  has_many :line_items, :dependent => :destroy
  has_many :items, :through => :line_items
  belongs_to :user
  has_many :payment_recvd
  has_many :payment_due
  accepts_nested_attributes_for :customer, :payment_due
  accepts_nested_attributes_for :line_items, :reject_if => :all_blank, :allow_destroy => true
  #after_create :create_payment_due
  scope :new_orders, lambda { where("created_at > ?", Time.zone.now - 1.month ) }
  scope :delivered, where("status = ?", "Delivered").includes(:customer)
  attr_accessor :customer_company
  validates :customer_id, presence: true
  validates :line_items, :length => { :minimum => 1 }

  def self.update_status(order_id)
    order = Order.includes(:line_items).find(order_id)
    count_check = order.line_items.count
    count = 0
    order.line_items.each do |line_item|
      count += 1 if line_item.delivered
    end
    if count == count_check
      order.status = "Delivered"
    elsif (1..count_check).include?(count)
      order.status = "Partially Delivered"
    else
      order.status = "In Process"
    end
    order.save
  end

end
