class PreparedsController < ItemsController

  def new
    @item = Prepared.new
  end

  def edit
    @item = Prepared.find(params[:id])
  end

  def create
    @item = current_user.items.build(params[:prepared])

    if @item.save
      redirect_to user_items_path(current_user), notice: "Item successfully added"
    else
      render "new"      
    end
  end

  def update
    @item = Prepared.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:prepared])
        format.html { redirect_to user_items_path(current_user), notice: 'Item was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
