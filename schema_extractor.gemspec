# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "schema_extractor/version"

Gem::Specification.new do |spec|
  spec.name          = "schema_extractor"
  spec.version       = SchemaExtractor::VERSION
  spec.authors       = ["nownabe"]
  spec.email         = ["nownabe@gmail.com"]

  spec.summary       = "Extract DB schema as output as specific format."
  spec.homepage      = "https://github.com/nownabe/schema_extractor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency "mysql2"
  spec.add_runtime_dependency "slop", "~> 4.0"
end
