require "dependency_resolution"
include DependencyResolution

require_relative "support/node"

RSpec.configure do |config|
  config.formatter = :doc
  config.disable_monkey_patching!

  Kernel.srand config.seed
end
