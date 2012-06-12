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
require 'rubydin/ui/abstract_container'
require 'rubydin/ui/listeners'

module Rubydin

	class ConfirmDialog < Java::org.vaadin.dialogs.ConfirmDialog

		include AbstractComponent
		include AbstractContainer
	
	    CONTENT_TEXT_WITH_NEWLINES = Java::org.vaadin.dialogs.ConfirmDialog::CONTENT_TEXT_WITH_NEWLINES
	    CONTENT_TEXT = Java::org.vaadin.dialogs.ConfirmDialog::CONTENT_TEXT
	    CONTENT_PREFORMATTED = Java::org.vaadin.dialogs.ConfirmDialog::CONTENT_PREFORMATTED
	    CONTENT_HTML = Java::org.vaadin.dialogs.ConfirmDialog::CONTENT_HTML
	    CONTENT_DEFAULT = Java::org.vaadin.dialogs.ConfirmDialog::CONTENT_DEFAULT
	
		class ConfirmListener
			
			include Java::org.vaadin.dialogs.ConfirmDialog::Listener
			include ListenerWithBlock
	
			def onClose dialog
				@block.call dialog
			end
		end
		
		def ConfirmDialog.show parent, caption, message, yes_caption, cancel_caption, &block		
			dialog = factory.create caption, message, yes_caption, cancel_caption
			dialog.content_mode = CONTENT_HTML
	        dialog.show parent, ConfirmListener.new(block), true
		end
			
	end

end
