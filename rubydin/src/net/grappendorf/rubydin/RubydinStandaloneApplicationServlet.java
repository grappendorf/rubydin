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
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.vaadin.terminal.gwt.server.AbstractApplicationServlet;


public abstract class RubydinStandaloneApplicationServlet extends AbstractApplicationServlet
{
	private static final long serialVersionUID = 2108024889491883155L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		onService(request, response);
		super.service(request, response);
	}
	
	protected void onService(HttpServletRequest request, HttpServletResponse response)
	{		
	}
}
