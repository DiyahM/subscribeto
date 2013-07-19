class InvoiceGenerator
  def self.create_invoices_for_week(weekly_schedule)
    weekly_schedule.customers.each do |customer|
      if customer.amount_due_for_week(weekly_schedule) > 0
        if weekly_schedule.customer_not_invoiced?(customer.id)
          puts customer.id
          invoice = customer.invoices.create(user_id: customer.user_id, weekly_schedule_id: weekly_schedule.id)
          invoice.delivery_details << customer.delivery_details_for_week(weekly_schedule)
        end
      end
    end
  end 
end
