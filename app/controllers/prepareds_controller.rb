class PreparedsController < ItemsController

  def new
    @item = Prepared.new
  end

  def create
    @item = Prepared.new(params[:prepared])

    if @item.save
      current_user.items << @item
      redirect_to user_items_path(current_user), notice: "Item successfully added"
    else
      render "new"      
    end
  end

end
