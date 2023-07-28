class TasksController < ApplicationController


  def index
    #   if params[:my_user]
    #  @tasks = Task.where(group_id: params[:group_id])
    @tasks = Task.where("deadline >= ?", Date.today).where(group_id: params[:group_id]).where(done: nil)
    @missed_tasks = Task.where("deadline < ?", Date.today).where(group_id: params[:group_id])
    @done_tasks = Task.where("deadline >= ?", Date.today).where(group_id: params[:group_id]).where(done: true)

    if params[:query].present?
      @tasks = Task.search_by_task_and_name(params[:query])
    else
      @tasks = Task.where(id: @tasks)
    end
    #   @tasks = @group.tasks.map do |task|
    #     task.user_id == params[:my_user]
    #   end


    #   @upcoming_tasks = Task.where("deadline > ?", Date.today).where(user_id: params[:my_user]).where(group_id: @group.id)
    #   @missed_tasks = Task.where("deadline < ?", Date.today).where(user_id: params[:my_user]).where(group_id: @group.id)
    #   # @my_date = Date.parse(Date.today).strftime("%d/%m/%Y")
    # else
    #   @group = Group.find(current_user.group_id)
    #   @tasks = @group.tasks
    #   @upcoming_tasks = Task.where("deadline > ?", Date.today).where(user_id: current_user.id).where(group_id: @group.id)
    #   @missed_tasks = Task.where("deadline < ?", Date.today).where(user_id: current_user.id).where(group_id: @group.id)
    # end
    # @upcoming_tasks = Task.where("deadline > ?", Date.today).where(user_id: current_user.id).where(group_id: @group.id)
    # This for user task dashboard
  end

  def usertasks
    @group = Group.find(params[:group_id])
    @task = Task.find(params[:id])
    @owner_of_task = @task.assigned_to_id
    @user = User.find(@owner_of_task)
    @my_tasks = Task.where(assigned_to_id:@owner_of_task)

  end

  def new

    @group = Group.find(params[:group_id])
    @user_ids_in_this_group =  MultipleGroup.where(group_id:  @group.id).pluck(:user_id)
    @user_profiles = User.where(id: @user_ids_in_this_group)
    @task = Task.new # Needed to instantiate the form_with
  end


  def create
    @task = Task.new(task_params)
    @group = Group.find(params[:group_id])
    @task.group = @group
    # @user = current_user
    # @task.user = @user

    @task.save


   redirect_to group_tasks_path(@group) # group_id task_id
  end

  def show
    @task = Task.find(params[:id])
    @group = Group.find(params[:group_id])
    @users = MultipleGroup.where(group_id:  @group.id).pluck(:user_id)
  end

  def finish_task
    @task = Task.find(params[:id])
    @group = Group.find(params[:group_id])
    @task.done = true
    @task.save

    redirect_to group_tasks_path(@group)
  end




  def progress
    @group = Group.find(params[:group_id])
    @task = Task.find(params[:id])

    @task.done = true

    @task.save

    redirect_to group_task_path(@group)
  end




  private

  def task_params
    params.require(:task).permit(:name, :assigned_to_id, :done, :urgent, :comments, :deadline, :recurrence, :recurring)
  end


end
