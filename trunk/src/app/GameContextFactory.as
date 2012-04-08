package src.app
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
		
		public function GameContextFactory() {}
		
		public static function createContext(gameApp:GameApp, contextId:int):GameContext
		{
			var ctx:GameContext = null;
			switch (contextId)
			{
				case MAIN_MENU: 
					ctx = new MainMenuContext(gameApp);
					break;
				default:
					ctx = new GameLevel(gameApp, contextId);
					break;
			}
			return ctx;
		}
	}

}