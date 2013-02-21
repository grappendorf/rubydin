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

	class Application < com.vaadin.Application

		class TransactionStartListener
			include com.vaadin.service.ApplicationContext::TransactionListener

			def initialize block
				@block = block
			end

			def transactionStart application, request
				@block.call application, request
			end

			def transactionEnd application, request
			end
		end

		class TransactionEndListener
			include com.vaadin.service.ApplicationContext::TransactionListener

			def initialize block
				@block = block
			end

			def transactionStart application, request
			end

			def transactionEnd application, request
				@block.call application, request
			end
		end

		class UserChangeListener
			include com.vaadin.Application::UserChangeListener

			def initialize block
				@block = block
			end

			def applicationUserChanged event
				@block.call event
			end
		end

		def terminalError e
			super
			#noinspection RubyResolve
			cause = e.throwable.cause
			if cause.kind_of? org.jruby.exceptions.RaiseException
				app_logger = java.util.logging.Logger.getLogger(Application.class.name)
				#noinspection RubyArgCount
				app_logger.log java.util.logging.Level::SEVERE, 'Ruby error:', cause
			end
		end

		def init
		end

		def self.global_close_handlers
			@global_close_handlers ||= []
		end

		def self.global_when_closed &block
			global_close_handlers << block
		end

		def close
			Application.global_close_handlers.each do |handler|
				handler.call
			end
			super
		end

		def when_transaction_start &block
			self.context.addTransactionListener TransactionStartListener.new block
		end

		def when_transaction_end &block
			self.context.addTransactionListener TransactionEndListener.new block
		end

		def when_user_changed &block
			self.addListener UserChangeListener.new block
		end

		def theme= theme
			self.setTheme theme
		end

		def main_window= window
			self.setMainWindow window
		end

	end

end