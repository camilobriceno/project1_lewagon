class BoughtItemsController < ApplicationController
  def index
    @user = current_user
    @shopping_list = ShoppingList.new
  end

  def new
    @user = current_user
    @boughtItem = BoughtItem.new
    @selected_products = params[:category][:category].drop(1)
    @products = @selected_products.map do |id|
      Product.find(id)
    end
    @group = Group.find(params[:group_id])

  end

  def create
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
    @products_id_array = params[:boughts]
    @group = Group.find(params[:group_id])

     @products_id_array.each do  |id|
      @boughtItem =  BoughtItem.new
      @product = Product.find(id)
      @boughtItem.shopping_list = @shopping_list
      @boughtItem.product = @product
      @boughtItem.user = current_user
      @boughtItem.save
     end

     redirect_to group_shopping_lists_path(@group)

  end


end
