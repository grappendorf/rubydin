$: << File.expand_path('../lib', __FILE__)

require 'rubydin-addons-serverpush/version'

Gem::Specification.new do |s|
	s.name        	= 'rubydin-addons-serverpush'
	s.version     	= Rubydin::VERSION_SERVERPUSH
	s.summary     	= 'Rubydin Addons ServerPush'
	s.description 	= 'Rubydin - Vaadin adapter for Ruby - Addons ServerPush'
	s.homepage		= 'http://www.grappendorf.net/rubydin'
	s.authors     	= ['Dirk Grappendorf']
	s.email       	= ['rubydin@grappendorf.net']
	s.files  		= Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	s.require_paths = ['lib']
	s.add_dependency 'rubydin', '>=6.7.8.1'
end

