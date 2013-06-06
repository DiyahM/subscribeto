class OrderTemplatesController < ApplicationController
  def create
    current_user.order_templates.create(params[:order])
    redirect_to user_orders_path(current_user), notice: "Order Template Created."
  end

  def destroy
    template = OrderTemplate.find(params[:id])
    template.destroy
    redirect_to user_orders_path(current_user), notice: "Order Template Deleted."
  end

  def create_order
    old_order = Order.find(params[:order_id])
    new_order = old_order.dup
    old_order.line_items.each do |line_item|
      new_order.line_items << line_item.dup
    end
    new_order.save
    redirect_to user_orders_path(current_user), notice: "Order Created."
  end
end
