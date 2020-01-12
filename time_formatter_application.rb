
class TimeFormatterApplication
  INTERNAL_ERROR = 500
  SUCCESS = 200

  def call(env)
    begin
      req = Rack::Request.new(env)
      request_time_format_str = req.params['format']
      status = SUCCESS
      content = time_now(request_time_format_str)
    rescue StandardError => error
      status = INTERNAL_ERROR
      content = error.message
    end
    [status, headers, [content]]
  end

  private

  def headers
    { 'content-type' => 'text/plain' }
  end

  def time_now(request_time_format_str)
    date_parts  = /([Yy]ear|month|day)/
    time_parts  = /(hour|minute|second)/
    format_str  = request_time_format_str
                  .gsub(date_parts) { |word| "%#{word[0]}" }
                  .gsub(time_parts) { |word| "%#{word[0].upcase}" }

    Time.now.strftime(format_str)
  end

end
