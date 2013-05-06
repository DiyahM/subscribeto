class ItemsController < ApplicationController
  autocomplete :vendor, :name, :full => true, :display_value => :name
  def index
    @items = current_user.items
  end

  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    if params[:item][:item_type] == "Raw Goods"
      @item = Raw.new(params[:item])
    else
      @item = Item.new(params[:item])
    end

    respond_to do |format|
      if @item.save
        current_user.items << @item
        format.html { redirect_to user_items_path, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to user_item_path(current_user, @item), notice: 'Item was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
