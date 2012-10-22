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

module Rubydin

	class Label < com.vaadin.ui.Label

		include AbstractComponent

		CONTENT_DEFAULT = com.vaadin.ui.Label::CONTENT_DEFAULT
		CONTENT_PREFORMATTED = com.vaadin.ui.Label::CONTENT_PREFORMATTED
		CONTENT_RAW = com.vaadin.ui.Label::CONTENT_RAW
		CONTENT_TEXT = com.vaadin.ui.Label::CONTENT_TEXT
		CONTENT_XHTML = com.vaadin.ui.Label::CONTENT_XHTML
		CONTENT_XML = com.vaadin.ui.Label::CONTENT_XML
		CONTENT_UIDL = com.vaadin.ui.Label::CONTENT_UIDL

		def initialize caption = '', type = CONTENT_TEXT
			super
		end
	end

	class HTMLLabel < Label

		def initialize caption = ''
			super caption, CONTENT_XHTML
		end

	end

end
