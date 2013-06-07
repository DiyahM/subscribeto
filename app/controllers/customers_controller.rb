class CustomersController < ApplicationController
  before_filter :authorize
  # GET /customers
  # GET /customers.json
  def index
    @customers = current_user.customers.order("updated_at DESC")
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.includes(:orders).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  def import_from_qb
    current_user.customers.create(JSON.parse(params[:customers]))
    flash[:notice] = "Customers Imported from Quickbooks"
    render :nothing => true
  end


  # POST /customers
  # POST /customers.json
  def create
    @customer = current_user.customers.build(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to user_customer_path(current_user, @customer), notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_order
    customer = Customer.find(params[:customer_id])
    @order = customer.orders.build
    session[:order] = @order
    redirect_to new_user_order_path(current_user) 
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to user_customers_path, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to user_customers_path, notice: 'Customer was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
