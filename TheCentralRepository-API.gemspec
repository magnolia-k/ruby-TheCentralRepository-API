# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'TheCentralRepository/API/version'

Gem::Specification.new do |spec|
  spec.name          = "TheCentralRepository-API"
  spec.version       = TheCentralRepository::API::VERSION
  spec.authors       = ["Magnolia.K"]
  spec.email         = ["magnolia.k@icloud.com"]

  spec.summary       = %q{Wrapper module for The Central Repository API}
  spec.description   = %q{Wrapper module for The Central Repository API}
  spec.homepage      = "https://github.com/magnolia-k/ruby-TheCentralRepository-API"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
