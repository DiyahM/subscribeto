class InvoicePdf < Prawn::Document
  def initialize(invoice, view, user)
    super(top_margin: 70)
    @invoice = invoice
    @customer = invoice.customer
    @view = view
    @user = user
    define_grid(:columns => 5, :rows => 8, :gutter => 10)
    right_header
    left_header
    main_content
  end

  def main_content
    text "Order Details", size: 15, style: :bold
    move_down 20
    order_table
    move_down 30
    text "Total Amount Due: ", size: 15, style: :bold
    text price(@invoice.amount_due), size:15, style: :bold
    move_down 30
    text @invoice.memo
  end

  def right_header
    grid([0,2], [1,4]).bounding_box do
      fill_color "FC0303"
      text "Invoice", size: 30, style: :bold, align: :right
      fill_color "5a5a5a"
      move_down 10
      invoice_table
    end
  end

  def invoice_table
    table(invoice_rows, :position => :right)
  end

  def order_table
    table line_item_rows, :position => :center, :width => 550
  end

  def invoice_rows
    [["Date","Terms","Due Date","Invoice #"],
     [@invoice.created_at.strftime("%B %d, %Y"),
      @customer.term, @invoice.due_date, @invoice.invoice_number]]
  end
  
  def line_item_rows
    [["Qty","Item Descritption", "Unit Price", "Total"]]+
    @invoice.order_quantities.map do |item|
      [item.quantity, invoice_item_desc(item), price(item.item.price), price(item.subtotal)]
    end
  end

  def invoice_item_desc(item)
    "#{item.delivery_detail.delivery_date.scheduled_for.strftime('%m/%d')} - #{item.item.name}"
  end

  def left_header
    grid([0,0],[3,1]).bounding_box do
      bill_from
      move_down 20 
      invoice_to
    end
  end

  def bill_from
    text @user.company_name, size: 14, style: :bold
    next_line
    text @user.name
    next_line
    text @user.phone_number
    next_line
    text @user.email
    next_line
    text @user.street_address
    next_line
    text "#{@user.city}, #{@user.state} #{@user.postal_code}"
  end

  def invoice_to
    text "Invoice to:", size: 14, style: :bold
    next_line
    text @customer.company_name
    next_line
    text @customer.poc_name
    next_line
    text @customer.phone_number
    next_line
    text @customer.email
    next_line
    text @customer.address_one
    if @customer.address_two != ""
      next_line
      text @customer.address_two
    end
    next_line
    text "#{@customer.city}, #{@customer.state}, #{@customer.postal_code}"
  end

  def next_line
    move_down 3
  end

  
  
  def line_items
    move_down 20
  end
  
  def price(num)
    @view.number_to_currency(num)
  end
end
