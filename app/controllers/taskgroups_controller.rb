class TaskgroupsController < ApplicationController

  before_filter :load_model, :only => [:show, :edit, :update, :destroy]


  def index
    @taskgroup = Taskgroup.new
    @taskgroups = Taskgroup.all
  end

  def new
  end

  def create
    @taskgroup = Taskgroup.new(params[:taskgroup])
    @taskgroup.save
    redirect_to taskgroups_path
  end

  def show
    @task = @model.tasks.build
    @tasks = @model.tasks.all(:include => :resource) 
    @resources = Resource.all(:conditions => {:enabled => true})
  end

  def edit
  end

  def update
    @model.update_attributes(params[:taskgroup])
    redirect_to taskgroups_path
  end

  def destroy
    @model.destroy 
    redirect_to taskgroups_path
  end

  private

  def load_model
    @model = Taskgroup.find(params[:id])
  end
end
