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

	module UriHandler

		include Java::com.vaadin.terminal.URIHandler
		
		# def handleURI context, relative_uri
			# handle_uri context, relative_uri
		# end
		
	end

	module ParameterHandler

		include Java::com.vaadin.terminal.ParameterHandler
		
	end

end
