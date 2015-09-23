require_relative 'log_line'

class LogLines
  def initialize(log_file:)
    @log_file = File.new(log_file)
  end

  def collection
    @_collection ||= log_file.each_line.reduce([]) do |collection, line|
      collection << LogLine.new(log_string: line)
    end
  end

  private

  attr_reader :log_file
end
