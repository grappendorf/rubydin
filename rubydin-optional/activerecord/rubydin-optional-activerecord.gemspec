require File.expand_path('../lib/rubydin-optional-activerecord/version', __FILE__)

Gem::Specification.new do |gem|
	gem.name = 'rubydin-optional-activerecord'
	gem.version = Rubydin::VERSION_ACTIVERECORD
	gem.summary = 'Rubydin Optional ActiveRecord'
	gem.description = 'Rubydin - Vaadin adapter for Ruby - ActiveRecord Components'
	gem.homepage = 'http://www.grappendorf.net/rubydin'
	gem.authors = ['Dirk Grappendorf']
	gem.email = ['rubydin@grappendorf.net']
	gem.files = Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.jar')
	gem.extra_rdoc_files = ['README.md'] 
	gem.require_paths = ['lib']

	gem.add_runtime_dependency 'rubydin', '~>6.8.0.1'
	gem.add_runtime_dependency 'activerecord', '~>3.2.3'

	gem.add_development_dependency 'rake', '>=0.9.2'	
end

