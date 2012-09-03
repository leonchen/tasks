module Resources
  class Base

    def initialize
    end

    def run(data)
    end
  end

  class Result
    attr_accessor :status, :value, :runtime
  end
end
