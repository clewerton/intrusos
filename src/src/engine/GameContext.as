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
		private var _inputManager:InputManager;
		
		public function GameContext(gameApp:GameApp, id:String)
		{
			_gameApp = gameApp;
			_inputManager = new InputManager(gameApp);
			gameApp.registerContext(this, id);
		}
		
		public override function dispose():void
		{
			_inputManager = null;
		}
		
		public function get inputManager():InputManager
		{
			return _inputManager;
		}
	
	}

}