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

	class DataMapperFormFieldFactory < FormFieldFactory

		def createField item, property_id, ui_context
			create_field item, property_id, ui_context
		end

		def create_field item, property_id, ui_context
			property = item.data.model.properties[property_id]
			type = property.class
			field = case
				when type == DataMapper::Property::String
					create_field_for_string property_id
				when type == DataMapper::Property::Text
					create_field_for_text property_id
				when type == DataMapper::Property::Boolean
					create_field_for_boolean property_id
				when type == DataMapper::Property::DateTime
					create_field_for_datetime property_id
				when type == DataMapper::Property::Integer
					create_field_for_integer property_id
				when type == DataMapper::Property::Serial
					create_field_for_string property_id
				when type == DataMapper::Property::Discriminator
					create_field_for_string property_id
			end
			create_generic_validators property, field 
			field
		end

		def create_field_for_string property_id
			TextField.new(create_caption property_id).tap do |f|
				f.null_representation = ''
			end
		end

		def create_field_for_text property_id
			TextArea.new(create_caption property_id).tap do |f|
				f.columns = 40
			end
		end
		
		def create_field_for_boolean property_id
			CheckBox.new create_caption property_id
		end

		def create_field_for_datetime property_id
			DateField.new create_caption property_id
		end

		def create_field_for_integer property_id
			TextField.new(create_caption property_id).tap do |f|
				f.null_representation = ''
			end
		end
		
		def create_generic_validators property, field
			field.required = (not property.allow_blank?)
		end
	end
	
end