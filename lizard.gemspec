require File.expand_path('../lib/lizard/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = "lizard"
  s.description   = %q{Very simple ImageMagick interface for Ruby}
  s.summary       = s.description
  s.homepage      = "https://github.com/adamcooke/lizard"
  s.version       = Lizard::VERSION
  s.files         = Dir.glob("{lib,colorspaces}/**/*")
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke"]
  s.email         = ["me@adamcooke.io"]
  s.licenses      = ['MIT']
end
