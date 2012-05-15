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

	module AbstractLayout

		def margin= margins
			setMargin(*margins)
		end

		def align child, alignment
			setComponentAlignment child, alignment
		end

		def expand_ratio child, ratio
			setExpandRatio child, ratio
		end
		
		alias expand expand_ratio
	end

end
