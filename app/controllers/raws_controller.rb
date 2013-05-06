class RawsController < ItemsController
  def new
    @item = Raw.new
  end

  def create
    @item = Raw.new(params[:raw])

    if @item.save
      current_user.items << @item
      redirect_to user_items_path(current_user), notice: 'Item was successfully created.'
    else
      format.html { render action: "new" }
      format.json { render json: @item.errors, status: :unprocessable_entity }
    end
    
  end
end
