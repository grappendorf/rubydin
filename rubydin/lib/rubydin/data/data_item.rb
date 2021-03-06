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

	class DataProperty < com.vaadin.data.util.AbstractProperty

		def initialize data, property
			#noinspection RubyArgCount
			super()
			@data = data
			@getter = @data.method(property)
			@setter = @data.method((property.to_s + '=').to_sym)
			@type = @getter.call.class
		end

		def getType
			@type
		end

		alias get_type getType

		def getValue
			@getter.call
		end

		def setValue value
			if @type == Fixnum and value.class == String
				value = Integer(value)
			end
			@setter.call value
		end

	end

	class DataItem < com.vaadin.data.util.PropertysetItem

		attr_reader :data

		def initialize data
			#noinspection RubyArgCount
			super()
			@data = data
			properties = data.methods.keep_if {|m| m.to_s =~ /^\w.*/ and data.methods.include?((m.to_s + '=').to_sym)}
			properties.each {|p| add_item_property p, DataProperty.new(data, p)}
		end

	end

	class ItemWrapper < Decorator

		def property property_id
			delegate.getItemProperty property_id.to_s
		end

	end
end
