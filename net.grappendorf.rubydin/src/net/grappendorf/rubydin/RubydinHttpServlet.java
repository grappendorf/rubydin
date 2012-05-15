/*
 * This file is part of the Rubydin project.
 *
 * Copyright 2012 Dirk Grappendorf, www.grappendorf.net
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package net.grappendorf.rubydin;


import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import org.jruby.embed.ScriptingContainer;


public class RubydinHttpServlet extends HttpServlet
{
	private static final long serialVersionUID = 505316319057992780L;

	private ScriptingContainer jruby;

	private HttpServlet jrubyServlet;
	
	@Override
	public void init(ServletConfig config) throws ServletException
	{
		super.init(config);
		getServletContext().log("Initializing Ruby HTTP Servlet '" + config.getServletName() + "'");
		jruby = RubydinContextListener.getRuby();
		String servletClass = config.getInitParameter("servletClass");
		if (servletClass == null)
		{
			servletClass = config.getServletName().replaceAll("\\s+", "");
		}
		jrubyServlet = (HttpServlet) jruby.runScriptlet(servletClass + ".new");
		jrubyServlet.init(config);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		jrubyServlet.service(req, resp);
	}
}
