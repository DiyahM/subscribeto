class PaymentDuesController < ApplicationController

  def index
    @invoices = current_user.payment_dues.includes(:order => :customer)
  end

  def create
    order = Order.includes(:line_items, :customer).find(params[:order_id])
    if order.payment_due
      order.payment_due.destroy
    end
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
    file = "#{user_invoice_url(current_user,@invoice)}.pdf"
    pdf = InvoicePdf.new(@invoice, view_context, current_user)
    Pony.mail(from: params[:from_email],
             to: params[:to_email],
            subject: params[:subject],
           body: params[:body],
             attachments: {"invoice.pdf" => pdf.render})
    redirect_to :back, notice: "Email successfully sent"
  end
end
