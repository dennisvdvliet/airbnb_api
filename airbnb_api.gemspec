
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airbnb_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'airbnb_api'
  spec.version       = AirbnbApi::VERSION
  spec.authors       = ['Dennis van der Vliet']
  spec.email         = ['dennis.vandervliet@gmail.com']

  spec.summary       = 'API Client for Airbnb API'
  spec.description   = 'API Client for Airbnb API'
  spec.homepage      = 'https://github.com/dennisvdvliet/airbnb_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock', '~> 3.1'
end
