class IndexController < ApplicationController
  def index
    limit = params[:limit] ? params[:limit].to_i : 10
    @latest_tasks = Task.includes(:taskgroup).order("last_run desc").limit(limit)
  end
end
