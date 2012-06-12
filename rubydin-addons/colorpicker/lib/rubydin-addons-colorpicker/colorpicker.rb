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

module Rubydin

	class ColorPicker < Java::com.vaadin.addon.colorpicker.ColorPicker

		include AbstractComponent

		class ColorChangeListener

			include Java::com.vaadin.addon.colorpicker.ColorPicker::ColorChangeListener 
			include ListenerWithBlock

			def colorChanged event
				@block.call event
			end
		end

		def when_color_changed &block
			addListener ColorChangeListener.new block
		end
		
		alias when_color_picked when_color_changed

		def color= rgb
			setColor Java::java.awt.Color.new rgb[0], rgb[1], rgb[2]
		end
		
	end

end
