# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'powwow/version'

Gem::Specification.new do |spec|
  spec.name          = "powwow"
  spec.version       = Powwow::VERSION
  spec.authors       = ["Nathaniel Watts"]
  spec.email         = ["reg@nathanielwatts.com"]
  spec.description   = %q{This gem interfaces with the powwow.io project, build for gSchool}
  spec.summary       = %q{See description :)}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "faraday", ">= 0.8.8"
  spec.add_dependency "thor"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "guard-minitest", "~> 2.0"
  spec.add_development_dependency "vcr", '~> 2.4'
end
