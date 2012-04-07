﻿package engine
{
	import evento.EventChannel;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameContext extends GameContainer
	{
		private var _gameApp:GameApp;
		
		// Processador de input
		private var _inputManager:InputManager;

		// Processador de comandos
		private var _commandProcessor:CommandProcessor;
		
		// Estado corrente do contexto
		private var _stateManager:StateManager;
		
		public function GameContext(gameApp:GameApp)
		{
			_gameApp = gameApp;
			reset();
		}
		
		protected function reset():void {
			_inputManager = new InputManager(_gameApp);
			_commandProcessor = new CommandProcessor();
			_stateManager = new StateManager();
		}
		
		public override function update():void
		{
			commandProcessor.processAll(inputManager.commands);
			super.update();
		}
		
		// Métodos relativos à estado
		protected function addState(stateId:uint, action:Function):void 
		{
			_stateManager.addState(stateId, action);
		}
		
		public function get activeState():uint {
			return _stateManager._activeStateId;
		}

		public function set activeState(value:uint):void 
		{
			_stateManager.activeStateId = value;
		}
		
		// Getters e Setters
		public function get inputManager():InputManager
		{
			return _inputManager;
		}
		
		public function set inputManager(value:InputManager):void 
		{
			_inputManager = value;
		}
		
		protected function get commandProcessor():CommandProcessor 
		{
			return _commandProcessor;
		}
		
		protected function get gameApp():GameApp 
		{
			return _gameApp;
		}
		
	}

}