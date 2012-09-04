class Resource < ActiveRecord::Base

  attr_accessible :name, :enabled

  has_many :tasks, :dependent => :destroy

  def self.get_resource(r, settings)
    return "Resources::#{r.name.classify}".constantize.new(settings)
  end
end
