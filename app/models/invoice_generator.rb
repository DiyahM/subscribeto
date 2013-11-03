class InvoiceGenerator
  def self.create_invoices_for_week(weekly_schedule)
    weekly_schedule.user.customers.each do |customer|
      if customer.amount_due_for_week(weekly_schedule) > 0
        if weekly_schedule.customer_not_invoiced?(customer.id)
          invoice_number = InvoiceGenerator.generate_invoice_number(weekly_schedule.user_id)
          invoice = customer.invoices.create(user_id: customer.user_id, weekly_schedule_id: weekly_schedule.id,
                                            invoice_number: invoice_number)
          invoice.order_items << customer.order_items_for_week(weekly_schedule)
        end
      end
    end
  end 

  def self.generate_invoice_number(user_id)
    invoice = User.find(user_id).invoices.order("invoice_number ASC").last
    if !invoice.nil?
      num = invoice.invoice_number + 1
    else
      num = 1000
    end
    return num
  end

end
