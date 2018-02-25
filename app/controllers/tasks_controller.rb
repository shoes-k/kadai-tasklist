class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new(content: 'detail')
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'task created'
      redirect_to @task
    else
      flash.now[:danger] = 'task can not be created'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'task updated'
      redirect_to @task
    else
      flash.now[:danger] = 'task can not be updated'
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'task deleted'
    redirect_to tasks_url
  end
end

private

def task_params
  params.require(:task).permit(:content, :status)
end
