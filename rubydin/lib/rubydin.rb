=begin

This file is part of the Rubydin project.

Copyright 2012 Dirk Grappendorf, www.grappendorf.net

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=end

require 'rubygems'
require 'java'
require 'ruby-debug-ide'
require 'filesystemwatcher'
require 'renum'
require 'rubydin/base/application'
require 'rubydin/resources/external_resource'
require 'rubydin/resources/theme_resource'
require 'rubydin/ui/alignment'
require 'rubydin/ui/builder'
require 'rubydin/ui/button'
require 'rubydin/ui/check_box'
require 'rubydin/ui/component'
require 'rubydin/ui/embedded'
require 'rubydin/ui/form'
require 'rubydin/ui/grid_layout'
require 'rubydin/ui/horizontal_layout'
require 'rubydin/ui/label'
require 'rubydin/ui/login_form'
require 'rubydin/ui/notification'
require 'rubydin/ui/panel'
require 'rubydin/ui/select'
require 'rubydin/ui/slider'
require 'rubydin/ui/table'
require 'rubydin/ui/text_area'
require 'rubydin/ui/text_field'
require 'rubydin/ui/units'
require 'rubydin/ui/vertical_layout'
require 'rubydin/ui/window'
require 'rubydin/data/data_item'
require 'rubydin/data/integer_validator'

module Rubydin

	def self.init config
		watch_files config['application_paths']
		start_debugger config if config['debug']
     end

	def self.watch_files paths
		watcher = FileSystemWatcher.new
		paths.each {|path| watcher.addDirectory path, '**/*.rb'}
		watcher.sleepTime = 1
		watcher.start do |status, file|
			if status == FileSystemWatcher::MODIFIED
				puts "Reload ruby file: #{file}"
				beginning = Time.now
				begin
					load file
				rescue
					print "Error: " + $!
				end
				puts "Done. Took me #{(Time.now - beginning) * 1000} milliseconds"
			end
		end
	end

	def self.start_debugger config
		puts 'Starting Rubydin in Debug Mode'
		STDOUT.sync = true
		STDERR.sync = true
    	Debugger.start_server nil, config['debug_port'] || 10000
	end
	
end