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

	class Slider < Java::com.vaadin.ui.Slider

		include AbstractComponent

		class ValueChangeListener

			include Java::com.vaadin.data.Property::ValueChangeListener
			include AbstractComponent::ListenerWithBlock

			def valueChange event
				@block.call event
			end
		end

		def initialize min = 0, max = 100, caption = ''
			super caption, min, max
		end

		def when_value_changed &block
			addListener ValueChangeListener.new block
		end

	end

end