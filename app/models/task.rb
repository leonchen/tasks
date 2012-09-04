class Task < ActiveRecord::Base

  attr_accessible :name, :enabled, :taskgroup_id, :resource_data

  belongs_to :taskgroup, :counter_cache => true

  before_create :initial_status

  def run
    running
    result = self.taskgroup.run_task(self)
    self.last_runtime = result.runtime
    self.last_status = result.status
    self.last_value = result.value
    Log.log(self, result) if self.taskgroup.logging
    finish
  end

  private

  def running
    self.is_running = true
    self.last_run = Time.now
    self.save
  end


  def finish
    self.is_running = false
    self.save
  end

  def initial_status
    self.last_run = 0
  end
end
