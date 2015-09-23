require 'minitest/autorun'
require_relative 'log_lines'

class LogLinesTest < MiniTest::Test
  def setup
    @log_lines = LogLines.new(log_file: 'test.log')
  end

  def test_initialize
    assert_kind_of LogLines, log_lines
  end

  def test_collection
    assert_kind_of Array, log_lines.collection
    assert_kind_of LogLine, log_lines.collection.first
  end

  private

  attr_reader :log_lines
end
