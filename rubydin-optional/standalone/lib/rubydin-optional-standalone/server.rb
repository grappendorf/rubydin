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

require 'rubydin'
require 'java/javax.servlet-api-3.0.1.jar'
require 'java/jetty-server-8.1.4.v20120524.jar'
require 'java/jetty-util-8.1.4.v20120524.jar'
require 'java/jetty-io-8.1.4.v20120524.jar'
require 'java/jetty-http-8.1.4.v20120524.jar'
require 'java/jetty-continuation-8.1.4.v20120524.jar'
require 'java/jetty-servlet-8.1.4.v20120524.jar'
require 'java/jetty-security-8.1.4.v20120524.jar'
require 'java/jetty-websocket-8.1.4.v20120524.jar'
require 'java/jetty-webapp-8.1.4.v20120524.jar'
require 'java/jetty-xml-8.1.4.v20120524.jar'
require 'rubydin-optional-standalone/application_servlet.rb'

# Server options:
#
# application_class: A subclass of Rubydin::Application
# production_mode: True to disable Vaadin debugging
# widgetset: Name of the widgetset file
# application_paths: Application directories for which to watch for file changes (auto-reload)

module Rubydin

	java_import 'javax.servlet.http.HttpServletResponse'
	java_import 'org.eclipse.jetty.server.Server'
	java_import 'org.eclipse.jetty.server.nio.SelectChannelConnector'
	java_import 'org.eclipse.jetty.server.handler.ContextHandler'
	java_import 'org.eclipse.jetty.server.handler.ResourceHandler'
	java_import 'org.eclipse.jetty.server.handler.HandlerList'
	java_import 'org.eclipse.jetty.servlet.ServletContextHandler'
	java_import 'org.eclipse.jetty.servlet.ServletHolder'
	java_import 'org.eclipse.jetty.servlet.DefaultServlet'
	java_import 'org.eclipse.jetty.webapp.WebAppContext'

	class Server

		class NonRootServingResourceHanlder < ResourceHandler

			def getResource path
				path != '/' ? super : nil
			end

		end

		def self.start options = {}
			logger = Logging.logger[Server]
			logger.info 'Starting Rubydin Standalone Server'

			production_mode = options[:production_mode] || false
			widgetset = options[:widgetset] || 'widgetset'
			port = options[:port] || 8080

			Rubydin::init options

			server = Server.new
			connector = SelectChannelConnector.new
			connector.port = port
			server.add_connector connector

			resource_handler1 = NonRootServingResourceHanlder.new
    		resource_handler1.directories_listed = true
 	  		resource_handler1.resource_base = 'public'
			handler1_context = ContextHandler.new
			handler1_context.context_path = '/'
			handler1_context.handler = resource_handler1

			resource_handler2 = NonRootServingResourceHanlder.new
    		resource_handler2.directories_listed = false
    		resource_handler2.resource_base = 'build'
			handler2_context = ContextHandler.new
			handler2_context.context_path = '/'
			handler2_context.handler = resource_handler2

			servlet_context = ServletContextHandler.new ServletContextHandler::SESSIONS
			servlet_context.context_path = '/'

			require 'rubydin-addons-serverpush'
			atmosphere_servlet = Java::org.atmosphere.cpr.AtmosphereServlet.new
			push_handler = Java::org.vaadin.addons.serverpush.VaadinServerPushHandler.new
			push_handler.heartbeat = 5000
			atmosphere_servlet.add_atmosphere_handler '/server-push', push_handler
			atmosphere_servlet_holder = ServletHolder.new atmosphere_servlet
			atmosphere_servlet_holder.set_init_parameter 'org.atmosphere.disableOnStateEvent', 'true'
			atmosphere_servlet_holder.set_init_parameter 'org.atmosphere.cdr.asyncSupport', 'org.atmosphere.container.JettyCometSupportWithWebSocket'
			atmosphere_servlet_holder.set_init_parameter 'org.atmosphere.useWebSocket', 'true'
			atmosphere_servlet_holder.set_init_parameter 'org.atmosphere.useNative', 'true'
			atmosphere_servlet_holder.set_init_parameter 'org.atmosphere.cpr.CometSupport.maxInactiveActivity', '120000'
			servlet_context.add_servlet atmosphere_servlet_holder, '/server-push'

			application_servlet = ApplicationServlet.new options
			application_servlet_holder = ServletHolder.new(application_servlet)
			application_servlet_holder.set_init_parameter 'productionMode', production_mode.to_s
			application_servlet_holder.set_init_parameter 'widgetset', widgetset
			servlet_context.add_servlet application_servlet_holder, '/*'
			servlet_context.add_servlet application_servlet_holder, '/'

			handlers = HandlerList.new
			handlers.handlers = [handler1_context, handler2_context, servlet_context]
			server.handler = handlers
			server.start
			server
		end

	end

end
