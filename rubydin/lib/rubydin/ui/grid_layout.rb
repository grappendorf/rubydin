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
require 'rubydin/ui/abstract_container'
require 'rubydin/ui/abstract_layout'

module Rubydin

	class GridLayout < com.vaadin.ui.GridLayout

		include AbstractComponent
		include AbstractContainer
		include AbstractLayout

		def initialize columns = 1, rows = 1
			super
		end

		def add_at component, column, row
			self.addComponent component, column, row, column, row
		end

		def add_from_to component, column1, row1, column2, row2
			self.addComponent component, column1, row1, column2, row2
		end

		def expand_column column_index, ratio
			self.setColumnExpandRatio column_index, ratio
		end

		def expand_row row_index, ratio
			self.setRowExpandRatio row_index, ratio
		end

	end

end
