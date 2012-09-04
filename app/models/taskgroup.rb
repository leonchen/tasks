require 'json'

class Taskgroup < ActiveRecord::Base
  attr_accessible :name, :resource_id, :resource_settings, :enabled, :interval, :logging
  serialize :resource_settings, Hash

  belongs_to :resource 
  has_many :tasks, :dependent => :destroy

  before_save :parse_resource_settings

  def run
    update_attribute(:is_running, true)
  end

  def stop
    update_attribute(:is_running, false)
  end

  def run_task(task)
    return get_resource.run(task.resource_data)
  end

  def get_resource
    @cached_resource ||= Resource.get_resource(self.resource, self.resource_settings)
    return @cached_resource
  end

  private

  def parse_resource_settings
    self.resource_settings = JSON.parse(self.resource_settings) if self.resource_settings.is_a? String
  end
end
