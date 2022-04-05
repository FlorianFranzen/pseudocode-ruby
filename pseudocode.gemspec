# frozen_string_literal: true

require_relative "lib/pseudocode/version"

Gem::Specification.new do |spec|
  spec.name = "pseudocode"
  spec.version = Pseudocode::VERSION
  spec.licenses = ['MIT']
  spec.authors = ["Florian Franzen"]
  spec.email = ["Florian.Franzen@gmail.com"]

  spec.summary = "Render Pseudocode.js from Ruby"
  spec.homepage = "https://github.com/FlorianFranzen/pseudocode-ruby"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = [
    "lib/pseudocode.rb", 
    "lib/pseudocode/version.rb", 
    "vendor/pseudocode/pseudocode.min.css", 
    "vendor/pseudocode/pseudocode.min.js" 
  ]
  spec.require_paths = [ "lib" ]

  spec.add_dependency "execjs", "~> 2.8"
  spec.add_dependency "katex", "~> 0.8"
end
