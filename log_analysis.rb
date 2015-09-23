require_relative 'array'
require_relative 'log_line'
require_relative 'log_lines'

ENDPOINTS = [
  { name: 'GET /api/users/{user_id}/count_pending_messages',
    method: 'GET',
    path_regexp: Regexp.new(/\/api\/users\/\d+\/count_pending_messages/) },
  { name: 'GET /api/users/{user_id}/get_messages',
    method: 'GET',
    path_regexp: Regexp.new(/\/api\/users\/\d+\/get_messages/) },
  { name: 'GET /api/users/{user_id}/get_friends_progress',
    method: 'GET',
    path_regexp: Regexp.new(/\/api\/users\/\d+\/get_friends_progress/) },
  { name: 'GET /api/users/{user_id}/get_friends_score',
    method: 'GET',
    path_regexp: Regexp.new(/\/api\/users\/\d+\/get_friends_score/) },
  { name: 'POST /api/users/{user_id}',
    method: 'POST',
    path_regexp: Regexp.new(/\/api\/users\/\d+/) },
  { name: 'GET /api/users/{user_id}',
    method: 'GET',
    path_regexp: Regexp.new(/\/api\/users\/\d+/) }
]

class LogAnalysis
  def initialize(log_lines:, endpoint:)
    @log_lines = log_lines
    @endpoint = endpoint
  end

  def to_s
    @_to_s ||= "#{endpoint[:name]}\n" \
      "URL calls: #{stats[:count]}\n" \
      "Response time (mean, median, mode): #{response_times_mean}, " \
      "#{response_times_median}, #{response_times_mode}\n" \
      "Most responding dyno: #{stats[:dynos].mode}\n\n"
  end

  private

  attr_reader :log_lines, :endpoint

  def stats
    @_stats ||= begin
      stats = { count: 0, response_times: [], dynos: [] }

      log_lines.each do |log_line|
        next unless log_line.method == endpoint[:method]
        next unless endpoint[:path_regexp].match log_line.path

        stats[:count] += 1
        stats[:response_times] << log_line.response_time
        stats[:dynos] << log_line.dyno
      end

      stats
    end
  end

  def response_times_mean
    @_response_times_mean ||= stats[:response_times].mean &&
      stats[:response_times].mean.round
  end

  def response_times_median
    @_response_times_median ||= stats[:response_times].median
  end

  def response_times_mode
    @_response_times_mode ||= stats[:response_times].mode
  end
end

log_lines = LogLines.new(log_file: 'sample.log').collection

ENDPOINTS.each do |endpoint|
  log_analysis = LogAnalysis.new(log_lines: log_lines, endpoint: endpoint)

  puts log_analysis
end
