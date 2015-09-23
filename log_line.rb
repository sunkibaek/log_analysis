# LogLine will try to parse a single log line formatted as below
# (newlined at space)
#
# 2014-01-09T06:15:17.858874+00:00
# heroku[router]:
# at=info
# method=POST
# path=/api/users/1145906359
# host=services.pocketplaylab.com
# fwd="107.220.72.53"
# dyno=web.14
# connect=2ms
# service=362ms
# status=200
# bytes=52

class LogLine
  attr_reader :method, :path, :dyno

  def initialize(log_string:)
    _timestamp,
    _heroku,
    _at,
    method,
    path,
    _host,
    _fwd,
    dyno,
    connect,
    service,
    _status,
    _bytes = log_string.split(' ')

    @method   = value_assigned_to method
    @path     = value_assigned_to path
    @dyno     = value_assigned_to dyno
    @connect  = duration_in_ms value_assigned_to(connect)
    @service  = duration_in_ms value_assigned_to(service)
  end

  def response_time
    connect + service
  end

  private

  def value_assigned_to(string)
    string.split('=')[1]
  end

  def duration_in_ms(string)
    string.split('ms')[0].to_i
  end

  attr_reader :connect, :service
end
