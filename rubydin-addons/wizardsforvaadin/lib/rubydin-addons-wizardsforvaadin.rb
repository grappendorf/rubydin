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

require 'java/wizards-for-vaadin-0.4.5.jar'
require 'rubydin-addons-wizardsforvaadin/version'
require 'rubydin-addons-wizardsforvaadin/wizardsforvaadin'
require 'i18n'

I18n.load_path << Dir[File.join File.dirname(__FILE__), 'rubydin-addons-wizardsforvaadin/locales/*.{rb,yml}']
