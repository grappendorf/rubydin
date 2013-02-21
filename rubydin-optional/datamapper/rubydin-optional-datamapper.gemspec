require File.expand_path('../lib/rubydin-optional-datamapper/version', __FILE__)

Gem::Specification.new do |gem|
	gem.name = 'rubydin-optional-datamapper'
	gem.version = Rubydin::VERSION_DATAMAPPER
	gem.summary = 'Rubydin Optional DataMapper'
	gem.description = 'Rubydin - Vaadin adapter for Ruby - DataMapper Components'
	gem.homepage = 'http://www.grappendorf.net/rubydin'
	gem.authors = ['Dirk Grappendorf']
	gem.email = ['rubydin@grappendorf.net']
	gem.files = Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	gem.extra_rdoc_files = ['README.md']
	gem.require_paths = ['lib']

	gem.add_runtime_dependency 'rubydin', '~>6.8.6.1'
	#gem.add_runtime_dependency 'datamapper', '~>1.3.0.beta'

	gem.add_development_dependency 'rake', '>=0.9.2.2'
end

