class StatusController < ApplicationController
  def running
    running_task = Task.includes(:taskgroup).where(:is_running => true)
    render :json => running_task.as_json(:include => [:taskgroup])
  end

  def last_run
    limit = params[:limit] ? params[:limit].to_i : 10
    run_tasks = Task.includes(:taskgroup).order("last_run desc").limit(limit)
    render :json => run_tasks.as_json(:include => [:taskgroup])
  end
end
