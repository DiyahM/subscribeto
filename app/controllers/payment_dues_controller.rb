class PaymentDuesController < ApplicationController

  def index
    @invoices = current_user.payment_dues.includes(:order => :customer)
  end

  def create
    order = Order.includes(:line_items, :customer).find(params[:order_id])
    invoice = order.create_payment_due
    Order.update_status(order.id,"Invoiced")
    redirect_to user_invoice_path(current_user,invoice), notice: "Invoice successfully created"
  end

  def show
    @invoice = PaymentDue.includes(:order => [:customer, :line_items]).find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context, current_user)
        send_data pdf.render, filename: "invoice_#{@invoice.id}", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def email
    @invoice = PaymentDue.includes(:order => [:customer]).find(params[:payment_due_id])
    from_email = current_user.email
    to_email = @invoice.order.customer.email
    my_subject = 'Invoice from ' + current_user.company_name
    file = "#{user_invoice_url(current_user,@invoice)}.pdf"
    pdf = InvoicePdf.new(@invoice, view_context, current_user)
    Pony.mail(from: from_email,
             to: to_email,
            subject: my_subject,
           body: 'Attached you will find an invoice for your recent order. Thank you for your business',
             attachments: {"invoice.pdf" => pdf.render})
    redirect_to :back, notice: "Email successfully sent"
  end
end
