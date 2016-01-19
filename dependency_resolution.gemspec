# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dependency_resolution/version'
require 'pathname'

Gem::Specification.new do |spec|
  spec.name          = "dependency_resolution"
  spec.version       = DependencyResolution::VERSION
  spec.authors       = ["Elliot Crosby-McCullough", "Chris Patuzzo"]
  spec.email         = ["elliot.cm@gmail.com", "chris@patuzzo.co.uk"]
  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir.glob('{lib}/**/*')# + %w(README.md LICENCE.txt)
  # spec.executables   = ['bad_link_finder']
  spec.test_files    = Dir.glob('spec/**/*')
  spec.require_paths = ["lib"]

  spec.add_dependency "rgl"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler"
end
