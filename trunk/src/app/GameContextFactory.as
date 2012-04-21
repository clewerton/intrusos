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
		public static const PAUSE_MENU:int = -3;
		public static const DEFEAT_GAME_MENU:int = -4;
		public static const VICTORY_GAME_MENU:int = -5;
		

		private static var _menuContext:MainMenuContext;
		private static var _pauseContext:PauseMenuContext;
		private static var _defeatContext:DefeatContext;
		private static var _victorytContext:VictoryContext;
		
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
				case DEFEAT_GAME_MENU: 
					if (_defeatContext == null) {
						_defeatContext = new DefeatContext(gameApp);
					}
					ctx = _defeatContext;
					break;
				case VICTORY_GAME_MENU: 
					if (_victorytContext == null) {
						_victorytContext = new VictoryContext(gameApp);
					}
					ctx = _victorytContext;
					break;
				default:
					ctx = new GameLevel(gameApp, contextId);
					break;
			}
			return ctx;
		}
	}

}