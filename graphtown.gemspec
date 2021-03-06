# frozen_string_literal: true

require_relative "lib/graphtown/version"

Gem::Specification.new do |spec|
  spec.name          = "graphtown"
  spec.version       = Graphtown::VERSION
  spec.author        = "Jared White"
  spec.email         = "jared@whitefusion.io"
  spec.summary       = "Easily consume GraphQL APIs for your Bridgetown website using a tidy Builder DSL on top of the Graphlient gem."
  spec.homepage      = "https://github.com/whitefusionhq/graphtown"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend)/!) }
  spec.test_files    = spec.files.grep(%r!^spec/!)
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "bridgetown", ">= 0.15", "< 2.0"
  spec.add_dependency "graphlient", "~> 0.4"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "nokogiri", "~> 1.6"
  spec.add_development_dependency "rack-test", "~> 1.1"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.2"
end
