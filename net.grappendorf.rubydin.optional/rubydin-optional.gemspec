$: << File.expand_path('../lib', __FILE__)

require 'rubydin-optional/version'

Gem::Specification.new do |s|
	s.name        	= 'rubydin-optional'
	s.version     	= Rubydin::VERSION_OPTIONAL
	s.summary     	= 'Rubydin Optional Components'
	s.description 	= 'Rubydin - Vaadin adapter for Ruby - Optional Components'
	s.homepage		= 'http://www.grappendorf.net/rubydin'
	s.authors     	= ['Dirk Grappendorf']
	s.email       	= ['rubydin@grappendorf.net']
	s.files  		= Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	s.require_paths = ['lib']
	s.add_dependency 'rubydin', '>=6.7.8.1'
end

