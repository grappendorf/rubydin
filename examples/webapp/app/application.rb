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

require 'rubydin_addons'

class ExampleApplication < Rubydin::Application
	
    def init
    	
        super
        self.theme = 'chameleon'
        
        window = Rubydin::Window.new

       	push = Rubydin::ServerPush.new '/rubydin-example-webapp'
		window.add push

        label = Rubydin::Label.new '0'
        window.add label
        
        button = Rubydin::Button.new 'Click me to reset!'
        button.when_clicked do
        	label.value = '0'
        	push.push 
        	window.show_notification 'Back to the beginning!'
        end
        window.add button        
		
        self.main_window = window
        
        thread = Thread.new do
        	loop do
        		sleep 1
        		label.value = label.value.to_i + 1
        		push.push
        	end
        end
    end
    
end
