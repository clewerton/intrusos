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
		private var _stage:Stage;
		private var _keys:Vector.<uint> = new Vector.<uint>();
		
		public function InputManager(stage:Stage) 
		{
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardDown, false, 0, true);
			_stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyboardUp, false, 0, true);
		}
		
		private function handleKeyboard(event:KeyboardEvent):void {
			_keys[event.keyCode] = true;
		}

		private function handleKeyboard(event:KeyboardEvent):void {
			delete _keys[event.keyCode];
		}
		
		public function get keys():Vector.<uint> 
		{
			return _keys;
		}
		
	}

}