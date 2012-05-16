$: << File.expand_path('../lib', __FILE__)

require 'rubydin/version'

Gem::Specification.new do |s|
	s.name			= 'rubydin'
	s.version		= Rubydin::VERSION
	s.summary		= 'Rubydin'
	s.description	= 'Rubydin - Vaadin adapter for Ruby'
	s.homepage		= 'http://www.grappendorf.net/rubydin'
	s.authors		= ['Dirk Grappendorf']
	s.email			= ['rubydin@grappendorf.net']
	s.files			= Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	s.require_paths	= ['lib']
end
