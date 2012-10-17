require File.expand_path('../lib/rubydin-optional-standalone/version', __FILE__)

Gem::Specification.new do |gem|
	gem.name = 'rubydin-optional-standalone'
	gem.version = Rubydin::VERSION_STANDALONE
	gem.summary = 'Rubydin Optional Standalone Server'
	gem.description = 'Rubydin - Vaadin adapter for Ruby - Standalone Server'
	gem.homepage = 'http://www.grappendorf.net/rubydin'
	gem.authors = ['Dirk Grappendorf']
	gem.email = ['rubydin@grappendorf.net']
	gem.files = Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	gem.extra_rdoc_files = ['README.md']
	gem.require_paths = ['lib']

	gem.add_runtime_dependency 'rubydin', '~>6.8.0.1'

	gem.add_development_dependency 'rake', '>=0.9.2.2'
end
