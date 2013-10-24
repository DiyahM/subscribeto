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

  def export_iif
    @invoices = Invoice.find(JSON.parse(params[:invoices]))
    respond_to do |format|
      format.iif { render iif: render_to_string(locals: { invoices:@invoices }), filename: "orderorchard_invoices" }
    end
  end


  def update
    invoice = current_user.invoices.find(params[:id])
    
    redirect_to :back, notice: "You cannot update a non drafted invoice" and return unless invoice.can_be_editted?

    if invoice.update_attributes(params[:invoice])
      redirect_to user_invoice_path(current_user, invoice), notice: "Successfully updated invoice"
    else
      redirect_to user_invoice_path(current_user, invoice), error: "Could not update your invoice"
    end
  end

  def change_state
    if params[:new_state] and Invoice::STATES.include?(params[:new_state])
      invoice = current_user.invoices.find(params[:id])
      if invoice and invoice.update_attributes(state: params[:new_state])
        redirect_to :back, notice: "Successfully tranisted the state of invoice to #{params[:new_state]}"
        return
      else
        redirect_to :back, notice: "Something is not right! Please try again later"
        return
      end
    end
    redirect_to :back, notice: "Invalid state passed, Please make sure you are doing a valid operation"
  end

  def index
    @invoices = current_user.invoices.order("invoice_number DESC")
  end

  def show 
    @invoice = current_user.invoices.find(params[:id])
  end

  def create
    @invoice = current_user.invoices.new(params[:invoice])
    if @invoice.save
      redirect_to user_invoices_path(current_user), notice: "Successfully created invoice"
    else
      render :new, error: "Could not create your invoice"
    end
  end

  def new
    @invoice = current_user.invoices.build
    @invoice.build_order_items
  end

end
