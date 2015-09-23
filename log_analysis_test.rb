require 'minitest/autorun'
require_relative 'log_analysis'

class LogAnalysisTest < MiniTest::Test
  def setup
    @log_analysis = LogAnalysis.new(
      log_lines: LogLines.new(log_file: 'test.log').collection,
      endpoint: sample_endpoint)
  end

  def test_initialize
    assert_kind_of(LogAnalysis, log_analysis)
  end

  def test_to_s
    assert_equal(sample_result_text, log_analysis.to_s)
  end

  private

  attr_reader :log_analysis

  def sample_endpoint
    {
      name: 'GET /api/users/{user_id}/count_pending_messages',
      method: 'GET',
      path_regexp: Regexp.new(/\/api\/users\/\d+\/count_pending_messages/)
    }
  end

  def sample_result_text
    sample_endpoint[:name] + "\n" +
      "URL calls: 6\n" +
      "Response time (mean, median, mode): 15, 14, 18\n" +
      "Most responding dyno: web.12\n\n"
  end
end
