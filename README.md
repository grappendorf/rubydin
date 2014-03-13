# Rubydin

_Note: This project is currently no longer developed. I abandoned Java programming altogether and now solely use
Ruby/Rails/CoffeeScript/AngularJS and similar tools. The latest Rubydin version uses Vaadin 6.8.6. Feel free to fork
this project if you want to extend on it._

Write Vaadin applications in the Ruby programming language.

	class RubydinApplication < Rubydin::Application
	  def init
	    super
	    self.theme = 'chameleon'
	    window = Rubydin::Window.new
	    button = Rubydin::Button.new 'Click me!'
	    button.when_clicked { window.show_notification 'Yikes!' }
	    window.add button
	    self.main_window = window
	  end
	end

## Licenses

### Rubydin

The Rubydin code is licensed under the the Apache License, Version 2.0
You find the license at http://www.apache.org/licenses/LICENSE-2.0

### Third party packages

License information about all included third party packages is found in
the README.rdoc files of the sub projects
