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
		// Id's positivos são reservados para contextos de levels. Todos as outras situações deverão ser id's negativos.
		public static const MAIN_MENU:int = -1;
		public static const PAUSE_MENU:int = -2;
		public static const DEFEAT_GAME_MENU:int = -3;
		public static const VICTORY_GAME_MENU:int = -4;
		public static const CONVOY_CONFIG:int = -5;
		
		// Contextos a serem salvos
		private static var _menuContext:MainMenuContext;
		private static var _pauseContext:PauseMenuContext;
		private static var _defeatContext:DefeatContext;
		private static var _victorytContext:VictoryContext;
		
		public function GameContextFactory() {}
		
		public static function createContext(context:GameContext, contextId:int):GameContext
		{
			var ctx:GameContext = null;
			switch (contextId)
			{
				case MAIN_MENU:
					if (_menuContext == null) {
						_menuContext = new MainMenuContext(context);
					}
					ctx = _menuContext;
					break;
				case PAUSE_MENU: 
					if (_pauseContext == null) {
						_pauseContext = new PauseMenuContext(context);
					}
					ctx = _pauseContext;
					break;
				case DEFEAT_GAME_MENU: 
					if (_defeatContext == null) {
						_defeatContext = new DefeatContext(context);
					}
					ctx = _defeatContext;
					break;
				case VICTORY_GAME_MENU: 
					if (_victorytContext == null) {
						_victorytContext = new VictoryContext(context);
					}
					ctx = _victorytContext;
					break;
				case CONVOY_CONFIG: 
					ctx = new ConvoyConfigContext(context);
					break;
				default:
					// Aqui carrega o contexto do level corrente
					ctx = new GameLevel(context, contextId);
					break;
			}
			return ctx;
		}
	}

}