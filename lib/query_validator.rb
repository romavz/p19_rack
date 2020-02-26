class QueryValidator
  VALID_FORMAT_ELEMENTS = %w[year Year month day hour minute second].freeze

  def validate!(format_str)
    if format_str.nil? || format_str.empty?
      raise FormatError, 'Format parameter not present'
    end

    invalid_elements = select_invalid_format_elements(format_str)
    if invalid_elements.any?
      raise FormatError, invalid_format_msg(invalid_elements)
    end
  end

  private

  def invalid_format_msg(invalid_elements)
    elements_list = invalid_elements.join(', ')
    "Unknown time format [#{elements_list}]"
  end

  def select_invalid_format_elements(format_str)
    request_elements = format_str.split(/[^[:alpha:]]+/)
    request_elements.reject { |element| VALID_FORMAT_ELEMENTS.include?(element) }
  end

end
