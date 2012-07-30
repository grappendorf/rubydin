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

	module RubydinJava
		
		java_import	Java::org.vaadin.teemu.wizards.Wizard
		
		class Wizard
			field_accessor :currentStep
		end
	end
	
	# Enhancements:
	# 
	# The 'Back', 'Next' and 'Finish' buttons are now enabled or disabled whenever the
	# possibility of the current step to go to the next/previous step or finish the wizard
	# changes. There are three new methods in a step: can_next(), can_back() and can_finish()
	# with which a step communicates it's ability to go next, back or finish the wizard.
	# At any time you can call update() on the wizard, to update the enable state of the
	# buttons whenever a steps ability to proceed has changed.
	# As a last resort, there remains the original option to return fals in the on_next() 
	# and on_back() methods to prevent the wizard from proceeding.
	class Wizard < RubydinJava::Wizard

		include AbstractComponent
		include Java::org.vaadin.teemu.wizards.event.WizardProgressListener
		
		def initialize
			super
			add_listener self
			@active_step_changed_callbacks = []
			@step_set_changed_callbacks = []
			@wizard_completed_callbacks = []
			@wizard_cancelled_callbacks = []
			next_button.caption = T('rubydin.addons.wizardsforvaadin.next_button')
			back_button.caption = T('rubydin.addons.wizardsforvaadin.back_button')
			finish_button.caption = T('rubydin.addons.wizardsforvaadin.finish_button')
			cancel_button.caption = T('rubydin.addons.wizardsforvaadin.cancel_button')
		end

		alias step addStep

		def activateStep step
			super
			update
		end
		
		def when_active_step_chanegd &block
			@active_step_changed_callbacks << block
		end

		def when_step_set_chanegd &block
			@step_set_changed_callbacks << block
		end

		def when_completed &block
			@wizard_completed_callbacks << block
		end

		def when_cancelled &block
			@wizard_cancelled_callbacks << block
		end

		def activeStepChanged event
			@active_step_changed_callbacks.each {|c| c.call event}
		end

		def stepSetChanged event
			@step_set_changed_callbacks.each {|c| c.call event}
		end

		def wizardCompleted event
			@wizard_completed_callbacks.each {|c| c.call event}
		end

		def wizardCancelled event
			@wizard_cancelled_callbacks.each {|c| c.call event}
		end
		
		def update
			can_next = (currentStep.can_next and not isLastStep(currentStep.to_java))
			can_back = (currentStep.can_back and not isFirstStep(currentStep.to_java))
			can_finish = (currentStep.can_finish or (currentStep.can_next and isLastStep(currentStep.to_java)))
			finishButton.setEnabled(can_finish)
			nextButton.setEnabled(can_next)
			backButton.setEnabled(can_back)
		end
	end

	class WizardStep

		include Java::org.vaadin.teemu.wizards.WizardStep

		# Return a caption string for the step
		def caption
			self.to_s
		end

		# Create and return the GUI content for the step
		def content
			Label.new T('rubydin.step_content_to_be_implemented')
		end
	
		def onAdvance
			on_next
		end

		# Called when the wizard proceeds to the next step
		# Return true if we can proceed or false to prevent the wizard from going on
		def on_next
			true
		end
		
		# Called when the wizard proceeds to the previous step
		# Return true if we can proceed or false to prevent the wizard from going on
		def on_back
			true
		end

		# Overwrite this method to specify whether we can go to the next step or not 
		def can_next
			true
		end

		# Overwrite this method to specify whether we can go to the previous step or not 
		def can_back
			true
		end
		
		# Overwrite this method to specify whether we can finish the wizard 
		def can_finish
			false
		end
		
	end

end
