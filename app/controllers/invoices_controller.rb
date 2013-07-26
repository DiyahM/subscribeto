class InvoicesController < ApplicationController

  def pdf
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context, current_user)
        send_data pdf.render, filename: "invoice_#{@invoice.id}", type: "application/pdf", disposition: "inline"
      end
    end
  end


  def email
    @invoice = Invoice.find(params[:invoice_id])
    file = "#{user_invoices_pdf_url(current_user,@invoice)}.pdf"
    pdf = InvoicePdf.new(@invoice, view_context, current_user)
    Pony.mail(from: params[:from_email],
             to: params[:to_email],
            subject: params[:subject],
           body: params[:body],
             attachments: {"invoice.pdf" => pdf.render})
    redirect_to :back, notice: "Email sent"
  end


  def update
    invoice = Invoice.find(params[:id])
    invoice.update_attributes!(params[:invoice])
    render nothing: true    
  end
end
