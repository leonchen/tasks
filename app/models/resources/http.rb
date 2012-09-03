require 'curb'
module Resources
  class Http < Base

    def initialize
    end

    def run(data)
      start_time = Time.now.to_f
      r = Result.new
      c = Curl::Easy.perform(data)
      r.value = c.body_str
      r.status = c.response_code
      r.runtime = Time.now.to_f - start_time
      return r
    end
  end
end
