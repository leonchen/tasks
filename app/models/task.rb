class Task < ActiveRecord::Base

  attr_accessible :name, :enabled, :taskgroup_id, :resource_id, :resource_data

  belongs_to :taskgroup, :counter_cache => true
  belongs_to :resource, :counter_cache => true 

  def run
    running
    result = Resource.get_resource(self.resource_id).run(self.resource_data)
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
end
