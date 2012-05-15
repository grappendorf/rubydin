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

	module Notification

		TYPE_HUMANIZED_MESSAGE = Java::com.vaadin.ui.Window::Notification::TYPE_HUMANIZED_MESSAGE
		TYPE_WARNING_MESSAGE = Java::com.vaadin.ui.Window::Notification::TYPE_WARNING_MESSAGE
		TYPE_ERROR_MESSAGE = Java::com.vaadin.ui.Window::Notification::TYPE_ERROR_MESSAGE
		TYPE_TRAY_NOTIFICATION = Java::com.vaadin.ui.Window::Notification::TYPE_TRAY_NOTIFICATION

		POSITION_CENTERED = Java::com.vaadin.ui.Window::Notification::POSITION_CENTERED
		POSITION_CENTERED_TOP = Java::com.vaadin.ui.Window::Notification::POSITION_CENTERED_TOP
		POSITION_CENTERED_BOTTOM = Java::com.vaadin.ui.Window::Notification::POSITION_CENTERED_BOTTOM
		POSITION_TOP_LEFT = Java::com.vaadin.ui.Window::Notification::POSITION_TOP_LEFT
		POSITION_TOP_RIGHT = Java::com.vaadin.ui.Window::Notification::POSITION_TOP_RIGHT
		POSITION_BOTTOM_LEFT = Java::com.vaadin.ui.Window::Notification::POSITION_BOTTOM_LEFT
		POSITION_BOTTOM_RIGHT = Java::com.vaadin.ui.Window::Notification::POSITION_BOTTOM_RIGHT

		DELAY_FOREVER = Java::com.vaadin.ui.Window::Notification::DELAY_FOREVER
		DELAY_NONE = Java::com.vaadin.ui.Window::Notification::DELAY_NONE

	end

end
