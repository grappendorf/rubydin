require File.expand_path('../lib/rubydin-optional-di/version', __FILE__)

Gem::Specification.new do |gem|
	gem.name = 'rubydin-optional-di'
	gem.version = Rubydin::VERSION_DI
	gem.summary = 'Rubydin Optional DependencyInjection'
	gem.description = 'Rubydin - Vaadin adapter for Ruby - DependencyInjection Components'
	gem.homepage = 'http://www.grappendorf.net/rubydin'
	gem.authors = ['Dirk Grappendorf']
	gem.email = ['rubydin@grappendorf.net']
	gem.files = Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	gem.extra_rdoc_files = ['README.md']
	gem.require_paths = ['lib']

	gem.add_runtime_dependency 'rubydin', '~>6.8.0.1'
	gem.add_runtime_dependency 'micon', '~>0.1.28'

	gem.add_development_dependency 'rake', '>=0.9.2.2'
end
