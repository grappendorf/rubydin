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
import javax.servlet.*;
import org.jruby.*;
import org.jruby.RubyInstanceConfig.CompileMode;
import org.jruby.embed.*;


public class RubydinContextListener implements ServletContextListener
{
	private static ScriptingContainer jruby;

	@Override
	public void contextInitialized(ServletContextEvent context)
	{
		context.getServletContext().log("Initializing Rubydin Ruby Runtime");
		long start = System.currentTimeMillis();

		String rubyHome = context.getServletContext().getInitParameter("rubyHome").trim();
		rubyHome = System.getProperty("rubyHome", rubyHome);

		String libraryPathsParam = context.getServletContext().getInitParameter("rubyLibraryPaths");
		libraryPathsParam = System.getProperty("rubyLibraryPaths", libraryPathsParam).replace(File.pathSeparatorChar,
						' ');
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

		String applicationPathsParam = context.getServletContext().getInitParameter("rubyApplicationPaths");
		applicationPathsParam = System.getProperty("rubyApplicationPaths", applicationPathsParam).replace(
						File.pathSeparatorChar, ' ');
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

		String debugParam = context.getServletContext().getInitParameter("rubyDebug");
		boolean debug = Boolean.valueOf(System.getProperty("rubyDebug", debugParam));
		String debugWaitForConnectionParam = context.getServletContext().getInitParameter(
						"rubyDebugWaitForConnection");
		boolean debugWaitForConnection = Boolean.valueOf(System.getProperty("rubyDebugWaitForConnectionDebug",
						debugWaitForConnectionParam));
		String debugPortParam = context.getServletContext().getInitParameter("rubyDebugPort");
		int debugPort = Integer.valueOf(System.getProperty("rubyDebugPort", 
						debugPortParam != null ? debugPortParam : "10000"));

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
		jruby.getProvider().getRubyInstanceConfig().setObjectSpaceEnabled(true);
		
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
						+ "require 'boot'\n"
						+ "require 'application'\n"; 
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
