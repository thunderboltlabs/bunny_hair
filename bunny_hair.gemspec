# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bunny_hair/version'

Gem::Specification.new do |spec|
  spec.name          = "bunny_hair"
  spec.version       = BunnyHair::VERSION
  spec.authors       = ["Robert Ross"]
  spec.email         = ["roberto@thunderboltlabs.com"]
  spec.description   = %q{A simple replacement for Bunny}
  spec.summary       = %q{Use this gem as a replacement for Bunny to do in-memory operations}
  spec.homepage      = "https://github.com/thunderboltlabs/bunny_hair"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "guard-rspec", "~> 3.0.0"
  spec.add_development_dependency "pry", "~> 0.9.12.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
end
