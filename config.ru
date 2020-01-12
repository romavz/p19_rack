require_relative 'midleware/path_validator'
require_relative 'midleware/query_validator'
require_relative 'time_formatter_application'

use PathValidator
use QueryValidator
run TimeFormatterApplication.new
