
class PathValidator
  def validate!(path)
    raise ResourceNotFoundError, 'Resource not found' if path != '/time'
  end
end
