=begin

This file is part of the CoYoHo Control Your Home System.

Copyright 2011-2012 Dirk Grappendorf, www.grappendorf.net

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

	class SessionScope < Hash

		def initialize
			@sessions = {}
		end

		def session session_id
			@sessions[session_id] ||= {}
		end

		def [] key
			session(Thread.current[:rubydin_session_id])[key]
		end

		def []= key, value
			session(Thread.current[:rubydin_session_id])[key] = value
		end

		def clear_session session_id
			@sessions.delete session_id
		end

		def clear
			@sessions.clear
		end

		def to_s
			@sessions.to_s
		end

		def inspect
			@sessions.inspect
		end

	end

end

::MICON.activate :session, Rubydin::SessionScope.new

Rubydin::Application.global_when_closed do
	puts '*********************'
	::MICON.custom_scopes[:session].clear_session Thread.current[:rubydin_session_id]
end
