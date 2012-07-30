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
			model = item.data.model			
			model_id = model.name.to_sym
			property = model.properties[property_id]
			caption = create_caption property_id, model_id
			validators = model.validators[property_id]
			type = property.class
			field = case
				when type == DataMapper::Property::String
					create_field_for_string property_id, caption, validators
				when type == DataMapper::Property::Text
					create_field_for_text property_id, caption
				when type == DataMapper::Property::Boolean
					create_field_for_boolean property_id, caption
				when type == DataMapper::Property::DateTime
					create_field_for_datetime property_id, caption
				when type == DataMapper::Property::Integer
					create_field_for_integer property_id, caption
				when type == DataMapper::Property::Serial
					create_field_for_string property_id, caption
				when type == DataMapper::Property::Discriminator
					create_field_for_string property_id, caption
			end
			create_generic_validators property_id, caption, property, field 
			field
		end

		def create_field_for_string property_id, caption, validators
			TextField.new(caption).tap do |f|
				f.null_representation = ''
				length_min = nil
				length_max = nil
				validators.each do |validator|
					case
						when validator.class == DataMapper::Validation::Rule::Length::Minimum
							length_min = validator.expected
						when validator.class == DataMapper::Validation::Rule::Length::Maximum
							length_max = validator.expected
						when validator.class == DataMapper::Validation::Rule::Length::Equal
							length_min = validator.expected
							length_max = validator.expected
						when validator.class == DataMapper::Validation::Rule::Format::Regexp
							f.add_validator RegexpValidator.new(
								T("rubydin.validator.string.format.pattern_error", field:caption, pattern:validator.format),
								validator.format.to_s, true)
					end
				end
				if length_min and length_max and length_min == length_max
					f.add_validator StringLengthValidator.new(
						T("rubydin.validator.string.length.equals_error", field:caption, length:length_min), length_min, length_max)
				elsif length_min
					f.add_validator StringLengthValidator.new(
						T("rubydin.validator.string.length.min_error", field:caption, length:length_min), length_min, Java::java.lang.Integer::MAX_VALUE)					 
				elsif length_max
					f.add_validator StringLengthValidator.new(
						T("rubydin.validator.string.length.max_error", field:caption, length:length_max), 0, length_max)					 
				end
				if length_max >= 80
					f.width = 80
				end
			end
		end

		def create_field_for_text property_id, caption
			TextArea.new(caption).tap do |f|
				f.columns = 40
			end
		end
		
		def create_field_for_boolean property_id, caption
			CheckBox.new caption
		end

		def create_field_for_datetime property_id, caption
			DateField.new caption
		end

		def create_field_for_integer property_id, caption
			TextField.new(caption).tap do |f|
				f.null_representation = ''
			end
		end
		
		def create_generic_validators property_id, caption, property, field
			if not property.allow_blank?
				field.required = true
				field.required_error = T("rubydin.validator.required.missing", field:caption)
			end
		end
	end
	
end