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

	class LoginForm < Java::com.vaadin.ui.LoginForm

		include AbstractComponent

		class LoginEvent

			def initialize event
				@event = event
			end

			def username
				@event.get_login_parameter 'username'
			end

			def password
				@event.get_login_parameter 'password'
			end

			def get_login_parameter
				@event.get_login_parameter
			end
		end

		class LoginListener

			include Java::com.vaadin.ui.LoginForm::LoginListener
			include AbstractComponent::ListenerWithBlock

			def on_login event
				@block.call LoginEvent.new event
			end
		end

		def when_logged_in &block
			add_listener LoginListener.new block
		end

	end

end