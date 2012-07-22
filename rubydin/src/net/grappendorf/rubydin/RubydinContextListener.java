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


import java.io.File;
import java.util.*;
import java.util.logging.Logger;
import javax.servlet.*;
import org.jruby.*;
import org.jruby.RubyInstanceConfig.CompileMode;
import org.jruby.embed.*;


public class RubydinContextListener implements ServletContextListener
{
	private static ScriptingContainer jruby;

	private static final Logger logger = Logger.getLogger(RubydinContextListener.class.getName());

	@Override
	public void contextInitialized(ServletContextEvent context)
	{
		context.getServletContext().log("Initializing Rubydin Ruby Runtime");
		long start = System.currentTimeMillis();

		String rubyHome = context.getServletContext().getInitParameter("rubyHome");
		rubyHome = System.getProperty("rubyHome", rubyHome);
		if (rubyHome == null)
		{
			logger.severe("No rubyHome specified. Either define it as a servlet init parameter or" +
							" set it as a system property.");
			throw new RuntimeException("No rubyHome specified");
		}
		rubyHome.trim();

		String libraryPathsParam = context.getServletContext().getInitParameter("libraryPaths");
		libraryPathsParam = System.getProperty("libraryPaths", libraryPathsParam);
		libraryPathsParam = libraryPathsParam != null ? libraryPathsParam : ""; 
		libraryPathsParam.replace(File.pathSeparatorChar, ' ');
		List<String> libraryPaths = new LinkedList<String>();
		for (String path : Arrays.asList(libraryPathsParam.split("\\s+")))
		{
			if (path.startsWith("/"))
			{
				libraryPaths.add(path);
			}
			else
			{
				libraryPaths.add(context.getServletContext().getRealPath(path));
			}
		}

		String applicationPathsParam = context.getServletContext().getInitParameter("applicationPaths");
		applicationPathsParam = System.getProperty("applicationPaths", applicationPathsParam);
		applicationPathsParam = applicationPathsParam != null ? applicationPathsParam : "";
		applicationPathsParam.replace(File.pathSeparatorChar, ' ');
		List<String> applicationPaths = new LinkedList<String>();
		for (String path : Arrays.asList(applicationPathsParam.split("\\s+")))
		{
			if (path.startsWith("/"))
			{
				applicationPaths.add(path);
			}
			else
			{
				applicationPaths.add(context.getServletContext().getRealPath(path));
			}
		}

		String bootFile = context.getServletContext().getInitParameter("bootFile");
		bootFile = System.getProperty("bootFile", bootFile);
		bootFile = (bootFile != null ? bootFile : "boot").trim();

		String applicationFile = context.getServletContext().getInitParameter("applicationFile");
		applicationFile = System.getProperty("applicationFile", applicationFile);
		applicationFile = (applicationFile != null ? applicationFile : "application").trim();

		String debugParam = context.getServletContext().getInitParameter("debug");
		boolean debug = Boolean.valueOf(System.getProperty("debug", debugParam));
		
		String debugWaitForConnectionParam = context.getServletContext().getInitParameter(
						"debugWaitForConnection");
		boolean debugWaitForConnection = Boolean.valueOf(System.getProperty("debugWaitForConnectionDebug",
						debugWaitForConnectionParam));
		
		String debugPortParam = context.getServletContext().getInitParameter("debugPort");
		debugPortParam = System.getProperty("debugPort", debugPortParam);
		int debugPort = Integer.valueOf(debugPortParam != null ? debugPortParam : "10000");

		List<String> loadPaths = new ArrayList<String>();
		loadPaths.add(rubyHome);
		loadPaths.addAll(libraryPaths);
		loadPaths.addAll(applicationPaths);

		System.setProperty("jruby.debug.fullTrace", "true");
		jruby = new ScriptingContainer(LocalContextScope.CONCURRENT);
		jruby.getProvider().getRubyInstanceConfig().setCompileMode(CompileMode.JIT);
		jruby.getProvider().getRubyInstanceConfig().setCompatVersion(CompatVersion.RUBY1_9);
		jruby.getProvider().getRubyInstanceConfig().setJRubyHome(rubyHome);
		jruby.getProvider().getRubyInstanceConfig().setLoadPaths(loadPaths);
		
		Map<String, Object> config = new HashMap<String, Object>();
		config.put("application_paths", applicationPaths);
		config.put("debug", debug);
		config.put("debug_port", debugPort);
		config.put("debug_wait_for_connection", debugWaitForConnection);
		jruby.put("config", config);

		final String script = ""
						+ "ENV['BUNDLE_GEMFILE'] = '" + context.getServletContext().getRealPath("/Gemfile") + "'\n"
						+ "require 'rubydin'\n"
						+ "Rubydin::init config;\n"
						+ "require '" + bootFile + "'\n"
						+ "require '" + applicationFile + "'\n"; 
		jruby.runScriptlet(script);
		long end = System.currentTimeMillis();
		context.getServletContext().log("Done. Took me " + (end - start) + " milli seconds");
	}

	@Override
	public void contextDestroyed(ServletContextEvent e)
	{
		jruby.terminate();
	}

	public static ScriptingContainer getRuby()
	{
		return jruby;
	}
}
