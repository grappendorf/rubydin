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

	# This module combines functions which are common to all layout components. 
	module AbstractLayout
		

		# Specify the component margins with either
		# 	comp.margin = all_margins_at_once
		# or
		# 	comp.margin = top, right, bottom, left
		def margin= margins
			setMargin(*margins)
		end

		# Set the alignment of component _child_ to be _alignment_
		def align child, alignment
			setComponentAlignment child, alignment
		end

		# Set the expand ratio of component _child_ to be _ratio_
		def expand child, ratio
			setExpandRatio child, ratio
		end
		
	end

end
