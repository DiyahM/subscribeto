class PaymentDuesController < ApplicationController

  def index
    @invoices = current_user.payment_dues.includes(:order => :customer)
  end
end
