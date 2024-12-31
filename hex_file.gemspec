# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hex_file/version'

Gem::Specification.new do |spec|
  spec.name          = "hex_file"
  spec.version       = HexFile::VERSION
  spec.authors       = ["Sean McCarthy"]
  spec.email         = ["sean@clanmccarthy.net"]
  spec.summary       = %q{Parses Intel HEX files and gives metadata about the file and records.}
  spec.description   = %q{Parses Intel HEX files and gives metadata about the file and records.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.3.7"
  spec.add_development_dependency "rake", "~> 12.3.3"
end
