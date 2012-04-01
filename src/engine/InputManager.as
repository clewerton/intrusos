package engine 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class InputManager 
	{
		private var _gameApp:GameApp;
		
		// Mapeamentos (key:uint -> command:String)
		protected var _mappings:Dictionary = new Dictionary();

		// Comandos no buffer de input (Array<String>)
		protected var _commands:Vector.<String> = new Vector.<String>();
		
		private var _enabled:Boolean = false;
		
		public function InputManager(gameApp:GameApp) 
		{
			_gameApp = gameApp;
		}

		public function addCommandMapping(key:uint, command:String) {
			_mappings[key] = command;
		}

		public function removeCommand(command:String) {
			for each(var key:uint in _mappings) {
				if (_mappings[key] == command) {
					delete _mappings[key];
				}
			}
		}

		public function get commands():Vector.<String> 
		{
			return _commands;
		}
		
		public function enable():void {
			if (_enabled) {
				return;
			}
			_gameApp.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardDown, false, 0, true);
			_gameApp.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyboardUp, false, 0, true);
			_enabled = true;
		}

		public function disable():void {
			if (!_enabled) {
				return;
			}
			_gameApp.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			_gameApp.stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyboardUp);
			_enabled = false;
		}
		
		private function handleKeyboardDown(event:KeyboardEvent):void {
			_commands.push(_mappings[event.keyCode]);
		}

		private function handleKeyboardUp(event:KeyboardEvent):void {
			_commands.pop();
		}
		
	}

}