class GroupsController < ApplicationController

  def index
    group_ids = MultipleGroup.where(user:current_user).pluck(:group_id)
    @groups = Group.where(id: group_ids)

    if params[:query].present?
      @groups = Group.search_by_group_and_description(params[:query])
    else
      @groups = Group.where(id: group_ids)
    end

  end

  def show
    @group = Group.find(params[:id])
    @shopping_list =  @group.shopping_list
    find_user_ids = MultipleGroup.where(group: @group).pluck(:user_id)
    @group_members = User.where(id:find_user_ids)
    @group_tasks = @group.tasks
    @group_shopping_list = @group.shopping_list
    @bought_items = BoughtItem.where(shopping_list_id: @group_shopping_list.id )

    @total_tasks = @group_tasks.length
    @finished_tasks = @group_tasks.select{|task| task.done}.length
    @not_finished_tasks = @group_tasks.reject{|task| task.done}.length

    @statusbar_done_width= (@finished_tasks * 100) / 3
    @stausbar_not_done_witdth = 100 -  @statusbar_done_width

    @total = @bought_items.map do |item|
          item.product.price
    end.reduce(0){|a,b| a+b }



  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @user = current_user
    # @task.user = @user

    @group.save
    @user.group_id = @group.id
    MultipleGroup.create(user_id: current_user.id, group_id: @group.id)
    ShoppingList.create(group: @group)
    @user.save
    redirect_to groups_path
  end

def join_a_group
    @groups = Group.all
    if params[:query].present?
      @groups = @groups.where(name: params[:query])
    end
end

  def join
    @groups = Group.all
  end

  def join_group

    @group = Group.find(params[:user][:group_id])
    @multigroup = MultipleGroup.new()
    @multigroup.group =  @group
    @multigroup.user =  current_user

    if @multigroup.save

      redirect_to group_path(@group)
    else
      redirect_to join_groups_path
    end
  end

  def dashboard
    @shopping_list = ShoppingList.find_by(group_id: params[:id])
    @bought_items = BoughtItem.where(shopping_list: @shopping_list)
    @total_products =  @bought_items.map{|item| item.product.price}.reduce(0){|a,b| a+b}
    @find_users = MultipleGroup.where(group: params[:id]).pluck(:user_id)
    @user_products = BoughtItem.where(user_id:@find_users)

    # @sums = @user_products.group(@find_users).includes(:product).sum(:price)
    @user_sums = @bought_items.group(:user_id).includes(:product).sum(:price)

  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :passcode, :photo)
  end

end
