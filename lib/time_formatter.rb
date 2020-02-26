
class TimeFormatter
  def format(time, input_format_str)
    date_parts  = /([Yy]ear|month|day)/
    time_parts  = /(hour|minute|second)/
    format_str  = input_format_str
                  .gsub(date_parts) { |word| "%#{word[0]}" }
                  .gsub(time_parts) { |word| "%#{word[0].upcase}" }

    time.strftime(format_str)
  end
end