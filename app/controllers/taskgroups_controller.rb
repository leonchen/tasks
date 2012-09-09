class TaskgroupsController < ApplicationController

  before_filter :load_model, :except => [:index, :create]


  def index
    @taskgroup = Taskgroup.new
    @taskgroups = Taskgroup.all
    @resources = Resource.all(:conditions => {:enabled => true})
  end

  def create
    @taskgroup = Taskgroup.new(params[:taskgroup])
    @taskgroup.save
    redirect_to taskgroups_path
  end

  def show
    @task = @model.tasks.build
    @tasks = @model.tasks.all 
  end

  def edit
    @resources = Resource.all(:conditions => {:enabled => true})
  end

  def update
    @model.update_attributes(params[:taskgroup])
    redirect_to taskgroups_path
  end

  def destroy
    @model.destroy 
    redirect_to taskgroups_path
  end


  def latest
    tasks = @model.tasks
    payload = {}
    tasks.each do |t|
      payload[t.name] = {
        :status => t.last_status,
        :value => t.last_value,
        :runtime => t.last_runtime,
        :timestamp => t.last_run.to_i,
        :resource_data => t.resource_data
      }
    end
    render :json => payload
  end

  private

  def load_model
    @model = Taskgroup.find(params[:taskgroup_id] || params[:id])
  end
end
