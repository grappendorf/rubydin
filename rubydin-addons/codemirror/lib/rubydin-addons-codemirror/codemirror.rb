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

module Rubydin

	class CodeMirror < Java::org.vaadin.codemirror2.CodeMirror

		include AbstractComponent

		MODE_TEXT = Java::org.vaadin.codemirror2.client.ui.CodeMode::TEXT
		MODE_XML = Java::org.vaadin.codemirror2.client.ui.CodeMode::XML
		MODE_JAVA = Java::org.vaadin.codemirror2.client.ui.CodeMode::JAVA
		MODE_JAVASCRIPT = Java::org.vaadin.codemirror2.client.ui.CodeMode::JAVASCRIPT
		MODE_CSS = Java::org.vaadin.codemirror2.client.ui.CodeMode::CSS
		MODE_SQL = Java::org.vaadin.codemirror2.client.ui.CodeMode::SQL
		MODE_PHP = Java::org.vaadin.codemirror2.client.ui.CodeMode::PHP
		MODE_PYTHON = Java::org.vaadin.codemirror2.client.ui.CodeMode::PYTHON
		MODE_LUA = Java::org.vaadin.codemirror2.client.ui.CodeMode::LUA
		MODE_CLOJURE = Java::org.vaadin.codemirror2.client.ui.CodeMode::CLOJURE
		MODE_COFFEESCRIPT = Java::org.vaadin.codemirror2.client.ui.CodeMode::COFFEESCRIPT
		MODE_DIFF = Java::org.vaadin.codemirror2.client.ui.CodeMode::DIFF
		MODE_GFM = Java::org.vaadin.codemirror2.client.ui.CodeMode::GFM
		MODE_GROOVY = Java::org.vaadin.codemirror2.client.ui.CodeMode::GROOVY
		MODE_HASKELL = Java::org.vaadin.codemirror2.client.ui.CodeMode::HASKELL
		MODE_HTMLEMBEDDED = Java::org.vaadin.codemirror2.client.ui.CodeMode::HTMLEMBEDDED
		MODE_HTMLMIXED = Java::org.vaadin.codemirror2.client.ui.CodeMode::HTMLMIXED
		MODE_JINJA2 = Java::org.vaadin.codemirror2.client.ui.CodeMode::JINJA2
		MODE_MARKDOWN = Java::org.vaadin.codemirror2.client.ui.CodeMode::MARKDOWN
		MODE_NTRIPLES = Java::org.vaadin.codemirror2.client.ui.CodeMode::NTRIPLES
		MODE_PASCAL = Java::org.vaadin.codemirror2.client.ui.CodeMode::PASCAL
		MODE_PERL = Java::org.vaadin.codemirror2.client.ui.CodeMode::PERL
		MODE_PLSQL = Java::org.vaadin.codemirror2.client.ui.CodeMode::PLSQL
		MODE_R = Java::org.vaadin.codemirror2.client.ui.CodeMode::R
		MODE_RST = Java::org.vaadin.codemirror2.client.ui.CodeMode::RST
		MODE_RUBY = Java::org.vaadin.codemirror2.client.ui.CodeMode::RUBY
		MODE_RUST = Java::org.vaadin.codemirror2.client.ui.CodeMode::RUST
		MODE_SCHEME = Java::org.vaadin.codemirror2.client.ui.CodeMode::SCHEME
		MODE_SMALLTALK = Java::org.vaadin.codemirror2.client.ui.CodeMode::SMALLTALK
		MODE_SPARQL = Java::org.vaadin.codemirror2.client.ui.CodeMode::SPARQL
		MODE_STEX = Java::org.vaadin.codemirror2.client.ui.CodeMode::STEX
		MODE_TIDDLYWIKI = Java::org.vaadin.codemirror2.client.ui.CodeMode::TIDDLYWIKI
		MODE_VELOCITY = Java::org.vaadin.codemirror2.client.ui.CodeMode::VELOCITY
		MODE_XMLPURE = Java::org.vaadin.codemirror2.client.ui.CodeMode::XMLPURE
		MODE_YAML = Java::org.vaadin.codemirror2.client.ui.CodeMode::YAML

		THEME_DEFAULT = Java::org.vaadin.codemirror2.client.ui.CodeTheme::DEFAULT
		THEME_COBALT = Java::org.vaadin.codemirror2.client.ui.CodeTheme::COBALT
		THEME_ECLIPSE = Java::org.vaadin.codemirror2.client.ui.CodeTheme::ECLIPSE
		THEME_ELEGANT = Java::org.vaadin.codemirror2.client.ui.CodeTheme::ELEGANT
		THEME_MONOKAI = Java::org.vaadin.codemirror2.client.ui.CodeTheme::MONOKAI
		THEME_NEAT = Java::org.vaadin.codemirror2.client.ui.CodeTheme::NEAT
		THEME_NIGHT = Java::org.vaadin.codemirror2.client.ui.CodeTheme::NIGHT
		THEME_RUBYBLUE = Java::org.vaadin.codemirror2.client.ui.CodeTheme::RUBYBLUE

		def initialize caption = '', mode = MODE_TEXT, theme = THEME_DEFAULT
			super caption
			setCodeMode mode
			setCodeTheme theme
		end

	end

end
