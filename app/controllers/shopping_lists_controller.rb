class ShoppingListsController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    @shopping_list = ShoppingList.find_by(group: @group)
    @bought_items = BoughtItem.where(shopping_list: @shopping_list)

    @total = @bought_items.map do |bought_item|
        bought_item.product.price
    end.reduce(0){|a,b| a + b }




  end

  def new
    @user = current_user
    @shopping_list = ShoppingList.new
    @selected_products = params[:category][:category].drop(1)
    @products = @selected_products.map do |id|
      Product.find(id)
    end

  end

  def new_item
    @user = current_user
    @shopping_list = ShoppingList.new
    # @add_product = params[:category][:product]
    # @add_quantity = params[:category][:quantity]
    # raise
    # raise
  end

  def create
    @shopping_list = ShoppingList(shopping_params)
    # raise
  end

  def pre_selection
    @shopping_list = ShoppingList.find_by(group_id: params[:group_id])
    @products = Product.all
    @group = Group.find(params[:group_id])

  end

  private

  def shopping_params
    params.require(:shopping_list).permit(:category)
  end

  def shopping_newitem
    params.require(:shopping_list).permit(group_id)
  end
end
