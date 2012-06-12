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

	class ActiveRecordContainer

		include Java::com.vaadin.data.Container

		class ActiveRecordItem

			include Java::com.vaadin.data.Item

			attr_reader :item

			def initialize model, item_id
				@model = model
				@item = model.find(item_id)
			end

			def getItemProperty property_id
				ActiveRecordProperty.new @item, property_id
			end

			alias property getItemProperty
			 
			def getItemPropertyIds
				@model.attribute_names
			end

			alias property_ids getItemPropertyIds
			
			def addItemProperty property_id, property
			end

			def removeItemProperty property_id
			end

		end

		class ActiveRecordProperty

			include Java::com.vaadin.data.Property

			def initialize item, property_id
				@item = item
				@getter = item.method(property_id)
				@setter = item.method((property_id.to_s + '=').to_sym)
			end

			def getType
				String
			end

			def getValue
				@getter.call
			end
			
			alias value getValue

			def setValue value
			end

			alias value= setValue
						
			def isReadOnly
				false
			end

			def setReadOnly read_only
			end

			def toString
				getValue.to_s
			end

			alias to_s toString

		end

		attr_reader :model

		def initialize model
			@model = model
		end

		def addContainerProperty property_id, type, default_value
			false
		end

		def addItem
			nil
		end

		def addItem item_id
			nil
		end

		def getContainerProperty item_id, property_id
			getItem(item_id).getItemProperty(property_id)
		end

		def getContainerPropertyIds
			@model.attribute_names
		end

		def getItem item_id
			ActiveRecordItem.new @model, item_id
		end

		alias item getItem

		def getItemIds
			@model.select(:id).map(&:id)
		end

		def getType property_id
			String
		end

		def removeAllItems
			false
		end

		def removeContainerProperty property_id
			false
		end

		def removeItem item_id
			false
		end

		def size
			@model.count
		end

		def containsId item_id
			@model.exists? item_id
		end

	end

end