﻿package lib.engine 
{
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Mapeador de eventos em comandos básicos (não suporta combinações de teclas).
	 */
	public class InputManager 
	{
		private var _gameApp:GameApp;
		
		// Mapeamentos (key:uint -> command:String)
		protected var _mappings:Dictionary;

		// Comandos no buffer de input (Array<String>)
		protected var _commands:Vector.<String>;
		//protected var _commands:Array = new Array();
		
		private var _enabled:Boolean = false;
		
		public function InputManager(gameApp:GameApp) {
			init();
			_gameApp = gameApp;
		}

		public function init():void {
			_mappings = new Dictionary();
			_commands = new Vector.<String>();
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
			var command:String = _mappings[event.keyCode];
			if (command != null && (_commands.indexOf(command) == -1)) {
				_commands.push(command);
			}
		}

		private function handleKeyboardUp(event:KeyboardEvent):void {
			_commands.splice(_commands.indexOf(_mappings[event.keyCode]), 1);
		}
		
		/*private function printBuffer(str:String):void {
			trace(str);
			for each(var com:String in _commands) {
				trace(com);
			}
			trace(str);
		}*/
		
	}

}