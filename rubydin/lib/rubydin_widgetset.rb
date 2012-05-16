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

require 'java/vaadin-6.7.8.jar'
require 'java/gwt-dev-2.4.0.jar'
require 'java/gwt-user-2.4.0.jar'
require 'java/validation-api-1.0.0.GA.jar'
require 'java/validation-api-1.0.0.GA-sources.jar'

module Rubydin

	module Widgetset

		def self.create widgetset = 'widgetset', widgetset_path = 'config', overwrite = false
			$CLASSPATH << File.expand_path(widgetset_path)
			classpath = $CLASSPATH.join File::PATH_SEPARATOR
			FileUtils.rm File.expand_path("#{widgetset}.gwt.xml", widgetset_path) 
			shell "java -classpath #{classpath} com.vaadin.terminal.gwt.widgetsetutils.WidgetSetBuilder #{widgetset}"
			
		end
		
		def self.compile widgetset = 'widgetset', widgetset_path = 'config', output_path = 'target/VAADIN/widgetsets'
			FileUtils.mkdir_p output_path
			$CLASSPATH << File.expand_path(widgetset_path)
			classpath = $CLASSPATH.join File::PATH_SEPARATOR
			shell "java -classpath #{classpath} com.google.gwt.dev.Compiler -war #{output_path} #{widgetset}"
		end

		def self.shell cmd
			IO.popen("#{cmd} 2>&1", 'r') {|out| out.each {|line| puts "  #{line}"}}
		end

	end

end