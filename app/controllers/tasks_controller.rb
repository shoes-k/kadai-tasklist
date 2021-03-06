class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :show, :update, :destroy]
  
  
  def index
    if logged_in?
      @tasks = current_user.tasks.page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    
    if @task.save
      flash[:success] = 'task created'
      redirect_to @task
    else
      flash.now[:danger] = 'task can not be created'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'task updated'
      redirect_to @task
    else
      flash.now[:danger] = 'task can not be updated'
      render :new
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'task deleted'
    redirect_to tasks_url
  end


  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status, :user)
  end

  def correct_user
    @tasks = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      flash[:danger] = 'you are invalid user'
      redirect_to root_url
    end
  end
end