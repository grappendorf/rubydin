require File.expand_path('../lib/rubydin/version', __FILE__)

Gem::Specification.new do |gem|
	gem.name = 'rubydin'
	gem.version = Rubydin::VERSION
	gem.summary = 'Rubydin'
	gem.description = 'Rubydin - Vaadin adapter for Ruby'
	gem.homepage = 'http://www.grappendorf.net/rubydin'
	gem.authors = ['Dirk Grappendorf']
	gem.email = ['rubydin@grappendorf.net']
	gem.files = Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.yml') + Dir.glob('lib/**/*.jar')
	gem.extra_rdoc_files = ['LICENSE.txt', 'README.md']
	gem.require_paths = ['lib']

	gem.add_runtime_dependency 'logging', '~>1.7.2'
	gem.add_runtime_dependency 'i18n', '~>0.6.0'

	gem.add_development_dependency 'rake', '>=0.9.2.2'
end
