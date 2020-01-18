require_relative 'lib/exceptions'
require_relative 'lib/path_validator'
require_relative 'lib/query_validator'
require_relative 'lib/time_formatter'

class TimeFormatterApplication
  INTERNAL_ERROR = 500
  SUCCESS = 200

  def initialize
    @time_formatter = TimeFormatter.new
    @path_validator = PathValidator.new
    @format_validator = QueryValidator.new
  end

  def call(env)
    begin
      req = Rack::Request.new(env)
      validate!(req)
      status = SUCCESS
      request_time_format_str = req.params['format']
      content = time_formatter.format(Time.now, request_time_format_str)
    rescue ValidationError => error
      status = error.error_code
      content = error.message
    rescue StandardError => error
      status = INTERNAL_ERROR
      content = error.message
    end
    [status, headers, [content]]
  end

  private

  attr_reader :time_formatter
  attr_reader :path_validator
  attr_reader :format_validator

  def validate!(request)
    path_validator.validate!(request.path_info)
    format_validator.validate!(request.params['format'])
  end

  def headers
    { 'content-type' => 'text/plain' }
  end

end
