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

require 'rubydin/ui/abstract_component'
require 'rubydin/ui/abstract_container'

module Rubydin

	class Window < Java::com.vaadin.ui.Window

		include AbstractComponent
		include AbstractContainer

		class CloseListener

			include Java::com.vaadin.ui.Window::CloseListener
			include ListenerWithBlock

			def windowClose event
				@block.call event
			end
		end

		def initialize caption = ''
			super caption
		end

		def when_closed &block
			addListener CloseListener.new block
		end

		def when_closed_do_nothing
			getListeners(Java::com.vaadin.ui.Window::CloseEvent).each{|l| removeListener l}
		end

		def removeWindow confirm
			super
		end
		
	end

end
