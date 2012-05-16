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

	class Table < Java::com.vaadin.ui.Table

		include AbstractComponent

		class BlockColumnGenerator

			include Java::com.vaadin.ui.Table::ColumnGenerator

			def initialize generator
				@generator = generator
			end

			def generateCell source, item_id, column_id
				@generator.call source, item_id, column_id
			end
		end

		class ItemClickListener

			include Java::com.vaadin.event.ItemClickEvent::ItemClickListener

			def initialize block
				@block = block
			end

			def itemClick event
				@block.call event
			end
		end

		def visible_columns columns
			setVisibleColumns columns.map(&:to_s)
		end

		def column_expand_ratio column, ratio
			setColumnExpandRatio column.to_s, ratio
		end

		def column_header column, header
			setColumnHeader column.to_s, header
		end

		def container_property property_id, type, default_value = nil
			if type == String
				java_class = Java::java.lang.String.java_class
			elsif type == Component
				java_class = Java::com.vaadin.ui.Component.java_class
			else
			java_class = type.superclass.java_class
			end
			addContainerProperty property_id.to_s, java_class, default_value
		end

		def add_item item_id, cells
			addItem cells.to_java, item_id
		end

		alias item getItem

		def when_item_clicked &block
			addListener ItemClickListener.new block
		end

		def generated_column column_id, &block
			addGeneratedColumn column_id.to_s, BlockColumnGenerator.new(block)
		end
	end

end
