class LineItemsController < ApplicationController

  def update
    LineItem.find(params[:id]).update_attributes!(params[:line_item])
    render nothing: true
  end
end
