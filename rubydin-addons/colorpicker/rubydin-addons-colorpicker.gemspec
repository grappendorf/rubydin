$: << File.expand_path('../lib', __FILE__)

require 'rubydin-addons-colorpicker/version'

Gem::Specification.new do |s|
	s.name        	= 'rubydin-addons-colorpicker'
	s.version     	= Rubydin::VERSION_COLORPICKER
	s.summary     	= 'Rubydin Addons ColorPicker'
	s.description 	= 'Rubydin - Vaadin adapter for Ruby - Addons ColorPicker'
	s.homepage		= 'http://www.grappendorf.net/rubydin'
	s.authors     	= ['Dirk Grappendorf']
	s.email       	= ['rubydin@grappendorf.net']
	s.files  		= Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	s.require_paths = ['lib']
	s.add_dependency 'rubydin', '>=6.7.8.1'
end

