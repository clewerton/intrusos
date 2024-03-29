﻿package src.app
{
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Fábrica resposável por criar os contextos.
	 */
	public class GameContextFactory
	{
		// Id's positivos são reservados para contextos de levels. Todos as outras situações deverão ser id's negativos.
		public static const MAIN_MENU:int = -1;
		public static const PAUSE_MENU:int = -2;
		public static const DEFEAT_GAME_MENU:int = -3;
		public static const VICTORY_GAME_MENU:int = -4;
		public static const CONVOY_CONFIG:int = -5;
		public static const INFO_INPUT:int = -6;
		public static const INFO_PATH:int = -7;
		public static const INFO_PLAY:int = -8;
		
		// Contextos a serem salvos
		private static var _menuContext:MainMenuContext;
		private static var _pauseContext:PauseMenuContext;
		private static var _defeatContext:DefeatContext;
		
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
					ctx = new VictoryContext(gameApp);
					break;
				case CONVOY_CONFIG: 
					ctx = new ConvoyConfigContext(gameApp);
					break;
				case INFO_INPUT: 
					ctx = new InputInfoContext(gameApp);
					break;
				case INFO_PATH: 
					ctx = new PathInfoContext(gameApp);
					break;
				case INFO_PLAY: 
					ctx = new GamePlayInfoContext(gameApp);
					break;
				default:
					// Aqui carrega o contexto do level corrente
					ctx = new GameLevel(gameApp, contextId);
					break;
			}
			return ctx;
		}
	}

}