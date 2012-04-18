﻿package src.app
{
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameContextFactory
	{
		public static const MAIN_MENU:int = -1;
		public static const HIGH_SCORE:int = -2;
		public static const PAUSE_MENU:int = -3;

		private static var _menuContext:MainMenuContext;
		private static var _pauseContext:PauseMenuContext;
		
		public function GameContextFactory() {}
		
		public static function createContext(gameApp:GameApp, contextId:int):GameContext
		{
			var ctx:GameContext = null;
			switch (contextId)
			{
				case MAIN_MENU:
					if (_menuContext == null) {
						_menuContext = new MainMenuContext(gameApp);
					}
					ctx = _menuContext;
					break;
				case PAUSE_MENU: 
					if (_pauseContext == null) {
						_pauseContext = new PauseMenuContext(gameApp);
					}
					ctx = _pauseContext;
					break;
				default:
					ctx = new GameLevel(gameApp, contextId);
					break;
			}
			return ctx;
		}
	}

}