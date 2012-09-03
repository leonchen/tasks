class Taskgroup < ActiveRecord::Base
  attr_accessible :name, :settings, :enabled, :interval, :logging

  has_many :tasks, :dependent => :destroy

  def run
    update_attribute(:is_running, true)
  end

  def stop
    update_attribute(:is_running, false)
  end
end
