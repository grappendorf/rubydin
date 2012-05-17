$: << File.expand_path('../lib', __FILE__)

require 'rubydin-addons-console/version'

Gem::Specification.new do |s|
	s.name        	= 'rubydin-addons-console'
	s.version     	= Rubydin::VERSION_CONSOLE
	s.summary     	= 'Rubydin Addons Console'
	s.description 	= 'Rubydin - Vaadin adapter for Ruby - Addons Console'
	s.homepage		= 'http://www.grappendorf.net/rubydin'
	s.authors     	= ['Dirk Grappendorf']
	s.email       	= ['rubydin@grappendorf.net']
	s.files  		= Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	s.require_paths = ['lib']
	s.add_dependency 'rubydin', '>=6.7.8.1'
end

