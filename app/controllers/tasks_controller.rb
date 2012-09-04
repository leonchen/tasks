class TasksController < ApplicationController
  before_filter :load_model, :except => [:create]

  def create
    @task = Task.new(params[:task])
    @task.taskgroup_id = params[:taskgroup_id].to_i
    @task.save
    redirect_to taskgroup_path(@task.taskgroup)
  end

  def edit
  end

  def update
    @model.update_attributes(params[:task])
    redirect_to taskgroup_path(@taskgroup)
  end

  def destroy
    @model.destroy 
    redirect_to taskgroup_path(@taskgroup)
  end

  def history
    render :json => (Log.where(:task_id => @model.id).collect do |l|
      {
        :status => l.status,
        :value  => l.value,
        :runtime => l.runtime,
        :timestamp => l.timestamp.to_i
      }
    end)
  end

  def latest
    render :json => {
      :status => @model.last_status,
      :value  => @model.last_value,
      :runtime => @model.last_runtime,
      :timestamp => @model.last_run.to_i
    }
  end

  private

  def load_model
    @model = Task.find(params[:id] || params[:task_id])
    @taskgroup = @model.taskgroup 
  end

end
