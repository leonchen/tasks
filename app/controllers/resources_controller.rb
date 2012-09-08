class ResourcesController < ApplicationController

  before_filter :load_model, :only => [:edit, :update, :destroy]

  def index
    @resource = Resource.new
    @resources = Resource.all
  end

  def create
    if Resource.resource_available?(params[:resource][:name])
      @resource = Resource.new(params[:resource])
      @resource.save
    end
    redirect_to resources_path 
  end

  def edit
  end

  def update
    @model.update_attributes(params[:resource])
    redirect_to resources_path 
  end

  def destroy
    @model.destroy 
    redirect_to resources_path
  end

  private

  def load_model
    @model = Resource.find(params[:id])
  end
end
