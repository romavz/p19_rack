class ValidationError < StandardError
  def error_code
    raise NotImplementedError, 'method must be implemented in child classes'
  end
end

class ResourceNotFoundError < ValidationError
  def error_code
    404
  end
end

class FormatError < ValidationError
  def error_code
    400
  end
end
