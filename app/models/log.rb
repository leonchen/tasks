class Log < ActiveRecord::Base
  attr_accessible :task_id, :status, :runtime, :value, :timestamp

  def self.log(task, result)
    self.create({
      :task_id => task.id,
      :status => result.status,
      :runtime => result.runtime,
      :value => result.value,
      :timestamp => Time.now
    })
  end
end
