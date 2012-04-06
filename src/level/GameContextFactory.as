package level
{
	import context.MainMenu;
	import engine.GameContext;
	import level.level1.World1;
	import engine.GameApp;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameContextFactory
	{
		public function GameContextFactory() {}
		
		public static function createContext(gameApp:GameApp, contextId:uint):GameContext
		{
			var ctx:GameContext = null;
			switch (contextId)
			{
				case 1: 
					ctx = new GameLevel(gameApp, new World1(gameApp));
					break;
				case 1000: 
					ctx = new MainMenu(gameApp);
					break;
			}
			return ctx;
		}
	}

}