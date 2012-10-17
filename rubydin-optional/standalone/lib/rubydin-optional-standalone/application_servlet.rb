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

require 'rubydin-optional-standalone/default_application'

module Rubydin

	java_import 'net.grappendorf.rubydin.RubydinStandaloneApplicationServlet'
	java_import 'javax.servlet.http.HttpServletRequest'
	java_import 'javax.servlet.http.HttpServletResponse'

	class ApplicationServlet < RubydinStandaloneApplicationServlet

		def initialize options
			@application_class = options[:application_class] || DefaultApplication
			super()
		end

		def onService request, response
			Thread.current[:rubydin_session_id] = request.session.id
			locale = request.locale.language.downcase
			Thread.current[:rubydin_locale] = locale
			I18n.locale = locale
		end

		def getNewApplication request
			@application_class.new
		end

		def getApplicationClass
			Java::com.vaadin.Application.java_class
		end
	end

end
