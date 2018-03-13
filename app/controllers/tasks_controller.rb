class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @tasks = Task.all.page(params[:page]).per(10)
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
end

private

def set_task
  @task = Task.find(params[:id])
end

def task_params
  params.require(:task).permit(:content, :status)
end
