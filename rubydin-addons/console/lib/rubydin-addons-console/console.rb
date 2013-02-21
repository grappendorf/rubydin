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

	class Console < org.vaadin.console.Console

		include AbstractComponent

		class Handler

			include org.vaadin.console.Console::Handler

			#noinspection RubyUnusedLocalVariable
			def getSuggestions(console, last_input)
				[]
			end

			#noinspection RubyUnusedLocalVariable
			def commandNotFound(console, argv)
			end

			#noinspection RubyUnusedLocalVariable
			def inputReceived(console, last_input)
			end

			#noinspection RubyUnusedLocalVariable
			def handleException(console, e, cmd, argv)
			end

		end

		def ps= ps
			self.setPs ps
		end

		def cols= cols
			self.setCols cols
		end

		def rows= rows
			self.setRows rows
		end

		def max_buffer_size= lines
			self.setMaxBufferSize lines
		end

		def greeting= greeting
			self.setGreeting greeting
		end
	end

end
