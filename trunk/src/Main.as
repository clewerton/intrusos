package src
{
	import flash.events.Event;
	import lib.engine.GameApp;
	import src.app.GameContextFactory;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Main extends GameApp
	{
		// Estados possíveis da engine
		public static const MENU:int = 1;					// menu
		public static const GAME_PLAY:int = 2;		// jogando
		public static const PAUSED:int = 3;				// jogo em pausa
		public static const NEXT_LEVEL:int = 4;		// jogo perdido
		public static const GAME_OVER:int = 5;		// jogo perdido
		
		public function Main():void
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initGame);
		}
		
		private function initGame(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initGame);
			
			// Adicionando contextos
			addGameContext(GameContextFactory.MAIN_MENU);
			addGameContext(levelIndex);
			
			// Adicionando estados
			addState(MENU, function() { switchContext(GameContextFactory.MAIN_MENU); });
			addState(GAME_PLAY, function() { 
				switchContext(levelIndex); 
			});
			addState(PAUSED, function() { });
			addState(NEXT_LEVEL, function() { addGameContext(levelIndex++); switchContext(levelIndex, true); });
			addState(GAME_OVER, function() { 
				switchContext(GameContextFactory.MAIN_MENU, true);
				addGameContext(levelIndex); 
			});
			
			
			switchContext(GameContextFactory.MAIN_MENU);			
			runApp();
		}

		private function addGameContext(indexId:int):void {
			addContext(GameContextFactory.createContext(this, indexId), indexId);
		}
	
	}

}