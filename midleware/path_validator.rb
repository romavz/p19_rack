class PathValidator

  def initialize(app)
    @app = app
  end

  def call(env)
    return resource_not_found_error if env['PATH_INFO'] != '/time'

    @app.call(env)
  end

  private

  def resource_not_found_error
    [404, { 'content_type' => 'text/plain' }, ['resource not found']]
  end

end
