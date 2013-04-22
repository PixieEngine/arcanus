# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arcanus/version'

Gem::Specification.new do |gem|
  gem.name          = "arcanus"
  gem.version       = Arcanus::VERSION
  gem.authors       = ["Daniel Moore"]
  gem.email         = ["yahivin@gmail.com"]
  gem.description   = %q{Command line tools for creating amazing games}
  gem.summary       = %q{Command line tools for creating amazing games}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "thor"
end
