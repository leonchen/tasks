require 'json'

class Taskgroup < ActiveRecord::Base
  attr_accessible :name, :settings, :enabled, :interval, :logging
  serialize :settings, Hash

  has_many :tasks, :dependent => :destroy
  before_save :parse_settings

  def run
    update_attribute(:is_running, true)
  end

  def stop
    update_attribute(:is_running, false)
  end

  private

  def parse_settings
    self.settings = JSON.parse(self.settings) if self.settings.is_a? String
  end
end
