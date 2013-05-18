class OrdersController < ApplicationController
  autocomplete :customer, :company_name, :full => true, :display_value => :company_name,
    :extra_data => [ :poc_name, :email, :phone_number, :address_one, :address_two,
                    :city, :state, :postal_code ] 
  autocomplete :item, :name, :full => true, :display_value => :name

  def get_autocomplete_items(parameters)
    items = super(parameters)
    if (items.first.class.name == "Item")
      items = items.where(:user_id => current_user.id, :item_type => "Available for sale")
    elsif (items.first.class.name == "Customer")
      items = items.where(:user_id => current_user.id)
    end
    return items
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders.includes(:customer)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.includes(:customer, :line_items).find(params[:id])
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    @order.build_customer
  end

  # GET /orders/1/edit
  def edit
    @order = Order.includes(:customer, :line_items).find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        current_user.orders << @order
        format.html { redirect_to user_order_path(current_user,@order), notice: 'Order was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to user_order_path(current_user, @order), notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to user_orders_url(current_user) }
      format.json { head :no_content }
    end
  end
end