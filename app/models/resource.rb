class Resource < ActiveRecord::Base

  attr_accessible :name, :enabled

  has_many :tasks, :dependent => :destroy


  class << self
    def get_resource(r, settings)
      return get_resource_class(r.name).new(settings)
    end

    def get_resource_class(name)
      return "Resources::#{name.classify}".constantize
    end

    def resource_available?(name)
      return defined?(get_resource_class(name))
    end

  end
end
