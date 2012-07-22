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
require 'java/vaadin-6.8.0.jar'
require 'java/gwt-dev-2.4.0.jar'
require 'java/gwt-user-2.4.0.jar'
require 'java/validation-api-1.0.0.GA.jar'
require 'java/validation-api-1.0.0.GA-sources.jar'
require 'java/javax.servlet-api-3.0.1.jar'
require 'java/rubydin-6.8.0.1.jar'
require 'logging'
require 'renum'

require 'rubydin/util/filesystemwatcher'
require 'rubydin/util/decorator'

module Rubydin
	autoload :Application, 'rubydin/base/application'
	autoload :ExternalResource, 'rubydin/resources/external_resource'
	autoload :StreamResource, 'rubydin/resources/stream_resource'
	autoload :ThemeResource, 'rubydin/resources/theme_resource'
	autoload :DataProperty, 'rubydin/data/data_item'
	autoload :DataItem, 'rubydin/data/data_item'
	autoload :ItemWrapper, 'rubydin/data/data_item'
	autoload :Validator, 'rubydin/data/validators'
	autoload :IntegerValidator, 'rubydin/data/integer_validator'
	autoload :IndexedContainerItemWrapper, 'rubydin/data/indexed_container'
	autoload :ListenerWithBlock, 'rubydin/ui/listeners'
	autoload :ItemClickListener, 'rubydin/ui/listeners'
	autoload :ValueChangeListener, 'rubydin/ui/listeners'
	autoload :Alignment, 'rubydin/ui/alignment'
	autoload :Units, 'rubydin/ui/units'
	autoload :Builder, 'rubydin/ui/builder'
	autoload :Button, 'rubydin/ui/button'
	autoload :CheckBox, 'rubydin/ui/check_box'
	autoload :Component, 'rubydin/ui/component'
	autoload :DateField, 'rubydin/ui/date_field'
	autoload :Embedded, 'rubydin/ui/embedded'
	autoload :InvalidValueError, 'rubydin/ui/form'
	autoload :FormFieldFactory, 'rubydin/ui/form'
	autoload :StandardFormFieldFactory, 'rubydin/ui/form'
	autoload :Form, 'rubydin/ui/form'
	autoload :GridLayout, 'rubydin/ui/grid_layout'
	autoload :HorizontalLayout, 'rubydin/ui/horizontal_layout'
	autoload :Label, 'rubydin/ui/label'
	autoload :LoginForm, 'rubydin/ui/login_form'
	autoload :Notification, 'rubydin/ui/notification'
	autoload :Panel, 'rubydin/ui/panel'
	autoload :RichTextArea, 'rubydin/ui/rich_text_area'
	autoload :Select, 'rubydin/ui/select'
	autoload :Slider, 'rubydin/ui/slider'
	autoload :HorizontalSpacer, 'rubydin/ui/spacer'
	autoload :VerticalSpacer, 'rubydin/ui/spacer'
	autoload :Table, 'rubydin/ui/table'
	autoload :TextArea, 'rubydin/ui/text_area'
	autoload :TextField, 'rubydin/ui/text_field'
	autoload :VerticalLayout, 'rubydin/ui/vertical_layout'
	autoload :Window, 'rubydin/ui/window'
end

module Rubydin

	def self.init config = {}
		config = Hash[config.map{|(k,v)| [k.to_s,v]}]
		@logger = Logging.logger[Rubydin]
		watch_files(config['application_paths'] || [])
		start_debugger config if config['debug']
    end

	def self.watch_files paths
		if paths == []
			return
		end
		@logger.info "Watching for file changes in these directories: #{paths}"
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
		require 'ruby-debug-ide'
		STDOUT.sync = true
		STDERR.sync = true
    	Debugger.start_server nil, config['debug_port'] || 10000
	end
	
end