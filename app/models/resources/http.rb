require 'curb'

module Resources
  class Http < Base

    def initialize(s)
      @host = s['host'] || ''
      @port = s['port'] || ''
      @extra_params = (s['params'] || {}).to_query
    end

    def run(path)
      unless path =~ /^http\:/
        path = "/#{path}" unless path =~ /^\// 
        path = "http://#{@host}:#{@port}#{path}"
      end
      path += '&' + @extra_params

      start_time = Time.now.to_f
      r = Result.new
      puts path
      begin
        c = Curl::Easy.perform(path)
        r.value = c.body_str
        r.status = c.response_code
      rescue
        r.value = ''
        r.status = 400 
      end
      r.runtime = Time.now.to_f - start_time
      return r
    end
  end
end
