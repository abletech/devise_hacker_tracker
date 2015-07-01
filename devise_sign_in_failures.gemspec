# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_hacker_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = "devise_hacker_tracker"
  spec.version       = DeviseHackerTracker::VERSION
  spec.authors       = ["Dawn Richardson"]
  spec.email         = ["dawn.richardson@abletech.co.nz"]

  spec.summary       = %q{Track failed attempts to sign in through devise}
  spec.description   = %q{Track failed attempts to sign in through devise to allow for increased security measures, such as locking sign in after failed attempts on several accounts from a single IP address.}
  spec.homepage      = "https://github.com/AbleTech/devise_hacker_tracker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency 'devise', '>= 3.4.1'
  spec.add_runtime_dependency 'rails', '~> 4.2.0'
end
