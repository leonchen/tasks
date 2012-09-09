require 'mysql2'
require 'json'

module Resources
  class Mysql < DB
    def initialize(settings)
      @client = Mysql2::Client.new(settings)
    end

    def run(sql)
      r = Result.new
      start_time = Time.now.to_f

      begin
        res = @client.query(sql)
        r.status = 'success'  
        r.value = res.to_json
      rescue Exception => e
        r.status = e.message
        r.value = '[]'
      end

      r.runtime = Time.now.to_f - start_time
      return r
    end
  end
end
