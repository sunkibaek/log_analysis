require 'minitest/autorun'
require_relative 'log_line'

class LogLineTest < MiniTest::Test
  def setup
    @log_line = LogLine.new(log_string: '2014-01-09T06:15:17.858874+00:00 ' \
      'heroku[router]: at=info method=POST path=/api/users/1145906359 ' \
      'host=services.pocketplaylab.com fwd="107.220.72.53" dyno=web.14 ' \
      'connect=2ms service=362ms status=200 bytes=52')
  end

  def test_method
    assert_equal 'POST', @log_line.method
  end

  def test_path
    assert_equal '/api/users/1145906359', @log_line.path
  end

  def test_dyno
    assert_equal 'web.14', @log_line.dyno
  end

  def test_response_time
    assert_equal 364, @log_line.response_time
  end
end
