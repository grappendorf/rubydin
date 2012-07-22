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

module Rubydin

	# This is a default application that is used when no application class was specified when
	# starting the standalone server.
	
	class DefaultApplication < Rubydin::Application
    	def init
	        super
    	    self.theme = 'chameleon'
        	window = Rubydin::Window.new 'Rubydin'
			window.content = Rubydin::VerticalLayout.new
			window.content.full_size
        	label = HTMLLabel.new <<-EOS
        		Welcome to <b>Rubydin</b>, a <b>Ruby</b> wrapper for the <b>Vaadin</b> framework!
        	EOS
        	label.unset_width
        	window.add label
        	window.content.align label, Rubydin::Alignment::MIDDLE_CENTER
        	button = Rubydin::Button.new 'Click me!'
        	button.when_clicked { window.show_notification 'Hey, you clicked the button :-)' }
        	window.add button
        	window.content.align button, Rubydin::Alignment::MIDDLE_CENTER
        	self.main_window = window
    	end
	end

end
