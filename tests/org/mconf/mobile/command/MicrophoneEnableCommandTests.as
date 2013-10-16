package org.mconf.mobile.command
{
	import flashx.textLayout.debug.assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.object.equalTo;
	import org.mconf.mobile.model.IUserSettings;
	import org.mconf.mobile.view.ui.IMicButton;
	import org.mconf.mobile.view.ui.MicButton;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.havingPropertyOf;
	import org.mockito.integrations.mock;
	import org.mockito.integrations.times;
	import org.mockito.integrations.verify;
	
	[Mock(type="org.mconf.mobile.model.IUserSettings")]
	public class MicrophoneEnableCommandTests
	{
		[Rule]
		public var mockitoRule: MockitoRule = new MockitoRule();
		
		/**
		 * Tests that the command microphoneEnabledOff really change/mantain the variable "selected" in the button false 
		 */
		[Test]
		public function execute_microphoneEnabledOffAndCheckSelectedProperty(): void
		{
			var command: MicrophoneEnableCommand = createCommand();
			command.boolean = false;
			command.execute();
			
			assertFalse(command.button.selected);
		}
		
		/**
		 * Tests that the command microphoneEnabledOff really change the visual in the button to desabled
		 */
		[Test]
		public function execute_microphoneEnabledOffAndCheckSelectedState(): void
		{
			var command: MicrophoneEnableCommand = createCommand();
			command.boolean = false;
			command.execute();
			
			assertThat(command.button.currentState, equalTo("unselected"));
		}
		
		/**
		 * Tests that the command microphoneEnabledOn really change the variable "selected" in the button 
		 */
		[Test]
		public function execute_microphoneEnabledOnAndCheckSelectedProperty(): void
		{
			var command: MicrophoneEnableCommand = createCommand();
			command.boolean = true;
			command.execute();
			
			assertTrue(command.button.selected);
		}
		
		/**
		 * Tests that the command microphoneEnabledOn really change the visual in the button 
		 */
		[Test]
		public function execute_microphoneEnabledOnAndCheckSelectedState(): void
		{
			var command: MicrophoneEnableCommand = createCommand();
			command.boolean = true;
			command.execute();
			
			assertThat(command.button.currentState, equalTo("selected"));
		}
		
		/**
		 * Tests that the command to enable after the disable works 
		 */
		[Test]
		public function execute_microphoneEnabledOnThenOffAndCheckIfOff(): void
		{
			var command: MicrophoneEnableCommand = createCommand();
			command.boolean = true;
			command.execute();
			
			var command1: MicrophoneEnableCommand = createCommand();
			command1.boolean = false;
			command1.execute();
			
			assertFalse(command1.button.selected);
		}
		
		/**
		 * Tests that the command to enable after the disable works 
		 */
		[Test]
		public function execute_microphoneEnabledOffThenOnAndCheckIfOn(): void
		{
			var command: MicrophoneEnableCommand = createCommand();
			command.boolean = false;
			command.execute();
			
			var command1: MicrophoneEnableCommand = createCommand();
			command1.boolean = true;
			command1.execute();
			
			assertTrue(command1.button.selected);
		}
		
		/**
		 * Creates the test subject with its dependencies.
		 */
		private function createCommand(): MicrophoneEnableCommand
		{
			var command: MicrophoneEnableCommand = new MicrophoneEnableCommand();
			command.userSettings = mock(IUserSettings);
			command.button = new MicButton();
			return command;
		}
	}
}