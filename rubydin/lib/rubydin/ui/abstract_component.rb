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

	# This module combines functions which are common to all components.
	module AbstractComponent

		# Completely expand the component to 100% in both directions
		def full_size
			setSizeFull
		end

		# Remove any width settings.
		def unset_width
			setWidth nil
		end

		alias undefined_width unset_width

		# Remove any height settings.
		def unset_height
			setHeight nil
		end

		alias undefined_height unset_height

		# Remove any size settings
		def unset_size
			setWidth nil
			setHeight nil
		end

		alias undefined_size unset_size

		# Specify the component width with either
		# 	comp.width = width
		# where _width_ is a string like '100%', or
		# 	comp.width = width, unit
		# where _width_ is a float an _unit_ is a constant from Units
		def width= width_optional_unit
			setWidth(*width_optional_unit)
		end

		# Specify the component height with either
		# 	comp.height = height
		# where _height_ is a string like '100%', or
		# 	comp.height = height, unit
		# where _height_ is a float an _unit_ is a constant from Units
		def height= height_optional_unit
			setHeight(*height_optional_unit)
		end

		def style_name= name
			setStyleName name
		end

	end

end
