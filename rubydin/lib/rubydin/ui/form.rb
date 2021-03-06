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

	class FormFieldFactory

		include com.vaadin.ui.FormFieldFactory

		def create_caption property_id, model_id = :_
			begin
				T! property_id, scope: [:domain, :attributes, model_id]
			rescue
				com.vaadin.ui.DefaultFieldFactory::createCaptionByPropertyId property_id.to_s.gsub(/_(.)/) {|w| w[1].upcase}
			end
		end

		def createField(item, property_id, ui_context)
		end

	end

	class StandardFormFieldFactory < FormFieldFactory

		def createField item, property_id, ui_context
			create_field item, property_id, ui_context
		end

		def create_field item, property_id, ui_context
			property = item.get_item_property property_id
			type = property.get_type
			if type <= Renum::EnumeratedValue
				field = create_field_for_enum property_id, type
			elsif type <= Integer
				field = create_field_for_integer property_id
			else
				field = create_field_for_string property_id
			end
			create_validators_for_annotations item, property_id, field
			field
		end

		def create_field_for_enum property_id, type
			field = Select.new create_caption property_id
			type.values.each {|v| field.add_item v}
			field.null_selection_allowed = false
			field
		end

		def create_field_for_integer property_id
			caption = create_caption property_id
			field = TextField.new caption
			field.add_validator IntegerValidator.new T('rubydin.validator.integer.number_error', field:caption)
			field
		end

		def create_field_for_string property_id
			TextField.new create_caption property_id
		end

		def create_validators_for_annotations item, property_id, field
		end

	end

	class Form < com.vaadin.ui.Form

		@@standard_form_field_factory = StandardFormFieldFactory.new

		def initialize caption = nil
			super()
			self.setWriteThrough false
			self.setFormFieldFactory @@standard_form_field_factory
			self.setCaption caption
		end

		def item_data_source= item
			self.setItemDataSource *item
		end

		def commit!
			begin
				commit
				true
			rescue com.vaadin.data.Validator::InvalidValueException
			false
			end
		end

		def form_field_factory= field_fctory
			self.setFormFieldFactory field_fctory
		end
	end

end