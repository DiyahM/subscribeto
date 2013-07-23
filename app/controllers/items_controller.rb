class ItemsController < ApplicationController
  before_filter :authorize

  def index
    @items = current_user.items
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
    @item = current_user.items.create(params[:item])

    respond_to do |format|
      if @item.errors.empty?
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
    @item.update_attributes(params[:item])

    respond_to do |format|
      if @item.errors.empty?
        format.html { redirect_to user_items_path(current_user), notice: 'Item was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to user_items_url, notice: 'Item was successfully removed.' }
      format.json { head :no_content }
    end
  end
end
