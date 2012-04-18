package src
{
	import flash.events.Event;
	import lib.engine.GameApp;
	import src.app.GameContextFactory;
	import src.app.GameLevel;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Main extends GameApp
	{
		// Estados possíveis da engine
		public static const MENU:int = 1;					// menu
		public static const START_CAMPAIGN:int = 2;		// jogando
		public static const PAUSED:int = 3;				// jogo em pausa
		public static const NEXT_LEVEL:int = 4;		// jogo ganho
		public static const START_GAME:int = 5;		// Começar jogo do nível corrente
		public static const GAME_OVER:int = 6;		// jogo perdido
		public static const BACK_TO_GAME:int = 7;		// jogo perdido

		
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
			addGameContext(GameContextFactory.PAUSE_MENU);
			
			// Adicionando estados
			addState(MENU, function() { 
				switchContext(GameContextFactory.MAIN_MENU); 
			});

			addState(PAUSED, function() { 
				switchContext(GameContextFactory.PAUSE_MENU, false); 
			});
			
			addState(START_CAMPAIGN, function() { 
				levelIndex = 1;
				addGameContext(levelIndex);
				switchContext(levelIndex); 
			});

			addState(NEXT_LEVEL, function() {
				levelIndex++;
				if (levelIndex <= GameLevel.MAX_LEVEL) {
					addGameContext(levelIndex);
					switchContext(levelIndex, false, true); 
				}
				else {
					activeState = GAME_OVER;
				}
			});
			
			addState(START_GAME, function() { 
				addGameContext(levelIndex);
				switchContext(levelIndex); 
			});

			addState(BACK_TO_GAME, function() { 
				switchContext(levelIndex);
			});
			
			addState(GAME_OVER, function() {
				removeContext(levelIndex);
				switchContext(GameContextFactory.MAIN_MENU);
			});
			
			switchContext(GameContextFactory.MAIN_MENU);
			runApp();
		}

		private function addGameContext(indexId:int):void {
			addContext(GameContextFactory.createContext(this, indexId), indexId);
		}
	
	}

}