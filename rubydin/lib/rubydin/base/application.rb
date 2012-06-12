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

	class Application < Java::com.vaadin.Application

		@@logger = Java::java.util.logging.Logger.getLogger self.name

		class TransactionStartListener
			include Java::com.vaadin.service.ApplicationContext::TransactionListener

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
			include Java::com.vaadin.service.ApplicationContext::TransactionListener

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
			include Java::com.vaadin.Application::UserChangeListener

			def initialize block
				@block = block
			end

			def applicationUserChanged event
				@block.call event
			end
		end

		def terminalError e
			super
			cause = e.throwable.cause
			if cause.kind_of? Java::org.jruby.exceptions.RaiseException
				@@logger.log Java::java.util.logging.Level::SEVERE, 'Ruby error:', cause
			end
		end

		def init
		end

		def when_transaction_start &block
			context.addTransactionListener TransactionStartListener.new block
		end

		def when_transaction_end &block
			context.addTransactionListener TransactionEndListener.new block
		end

		def when_user_changed &block
			addListener UserChangeListener.new block
		end

	end

end