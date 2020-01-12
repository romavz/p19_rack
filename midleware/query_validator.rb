class QueryValidator
  VALID_FORMAT_ELEMENTS = %w[year Year month day hour minute second].freeze


  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    format = req.params['format']
    return format_parameter_not_present_error if format.nil? || format.empty?

    invalid_elements = select_invalid_format_elements(format)
    return invalid_format_elements_error(invalid_elements) if invalid_elements.any?

    @app.call(env)
  end

  private

  def build_error_response(message)
    [400, { 'content-type' => 'text/plain' }, [message]]
  end

  def format_parameter_not_present_error
    build_error_response('Format parameter not present')
  end

  def invalid_format_elements_error(invalid_elements)
    elements_list = invalid_elements.join(', ')
    build_error_response("Unknown time format [#{elements_list}]")
  end

  def select_invalid_format_elements(format_str)
    request_elements = format_str.split(/[^[:alpha:]]+/)
    request_elements.reject { |element| VALID_FORMAT_ELEMENTS.include?(element) }
  end

end
