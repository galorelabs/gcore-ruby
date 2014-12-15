# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "gcore-ruby"
  spec.version       = `cat .version`
  spec.authors       = ["Ardee Aram", "Karlo Escota"]
  spec.email         = ["ardee.aram@galoretv.com", "karlo.escota@galoretv.com"]
  spec.summary       = %q{Ruby Wrapper for the GCore API.}
  spec.description   = %q{Ruby Wrapper for the GCore API.}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.files         = `find lib/gcore -name \*.rb`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", '~> 0'
  spec.add_runtime_dependency 'rest-client','~> 1.6', '>= 1.6.7'
end
