# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crumpet/version'

Gem::Specification.new do |spec|
  spec.name          = "crumpet"
  spec.version       = Crumpet::VERSION
  spec.authors       = ["Grant Colegate"]
  spec.email         = ["blaknite@thelanbox.com.au"]

  spec.summary       = "Simple breadcrumbs for Rails"
  spec.homepage      = "https://github.com/blaknite/crumpet"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3"

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
