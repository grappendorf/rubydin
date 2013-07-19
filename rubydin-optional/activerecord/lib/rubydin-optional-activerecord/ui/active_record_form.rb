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

	class ActiveRecordFormFieldFactory < FormFieldFactory

		def createField item, property_id, ui_context
			create_field item, property_id, ui_context
		end

		def create_field item, property_id, ui_context
			caption = create_caption property_id
			type = item.data.column_for_attribute(property_id).type
			field = case type
						when :text
							create_field_for_text property_id, caption
						when :string
							create_field_for_string property_id, caption
						when :boolean
							create_field_for_boolean property_id, caption
						when :integer
							create_field_for_integer property_id, caption
					end
			field
		end

		def create_field_for_string property_id, caption
			TextField.new(caption).tap do |f|
				f.null_representation = ''
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

		def create_field_for_integer property_id, caption
			TextField.new(caption).tap do |f|
				f.null_representation = ''
			end
		end

	end

end