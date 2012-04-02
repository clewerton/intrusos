package engine
{
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
		
		public function GameContext(gameApp:GameApp)
		{
			_gameApp = gameApp;
			_inputManager = new InputManager(_gameApp);
			_commandProcessor = new CommandProcessor();
		}
		
		public override function update():void
		{
			commandProcessor.process(inputManager.commands);
			super.update();
		}
		
		public override function dispose():void
		{
			super.dispose();
			_inputManager = null;
			_commandProcessor = null;
		}
		
		public function get inputManager():InputManager
		{
			return _inputManager;
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