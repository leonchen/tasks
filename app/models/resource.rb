class Resource < ActiveRecord::Base

  attr_accessible :name, :enabled

  has_many :tasks, :dependent => :destroy

  def self.get_resource(id)
    @@resources ||= self.where(:enabled => true).inject({}) do |h, r|
      h[r.id] = "Resources::#{r.name.classify}".constantize.new
      h
    end
    return @@resources[id]
  end
end
