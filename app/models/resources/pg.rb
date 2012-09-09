require 'pg'
require 'json'

module Resources
  class PG < DB
    def initialize(settings)
      @conn = PG.connect(settings)
    end

    def run(sql)
      r = Result.new
      start_time = Time.now.to_f

      begin
        res = @conn.exec(sql)
        r.status = res.res_status
        r.value = r.values.to_json
      rescue Exception => e
        r.status = e.message
        r.value = '[]';
      end

      r.runtime = Time.now.to_f - start_time
      return r
    end
  end
end
