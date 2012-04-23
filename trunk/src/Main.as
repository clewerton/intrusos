package src
{
	import flash.events.Event;
	import lib.engine.GameApp;
	import src.app.GameContextFactory;
	import src.app.GameLevel;
	import flash.display.StageScaleMode;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Main extends GameApp
	{
		// Estados possíveis da engine
		public static const MAIN_MENU:int = 1;				// menu
		public static const START_CAMPAIGN:int = 2;		// jogando campanha
		public static const PAUSED:int = 3;						// jogo em pausa
		public static const NEXT_LEVEL:int = 4;				// próxima fase
		public static const START_GAME:int = 5;				// Começar jogo da fase corrente
		public static const GAME_OVER:int = 6;				// jogo perdido
		public static const BACK_TO_GAME:int = 7;			// voltando à tela do jogo
		public static const DEFEAT_MATCH:int = 8;			// partida perdida
		public static const VICTORY_MATCH:int = 9;		// partida ganha
		public static const RESTART_GAME:int = 10;		// recomeçando jogo

		
		public function Main():void
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener(Event.ADDED_TO_STAGE, initGame);
		}
		
		private function initGame(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initGame);
			
			// Contextos a serem mantidos em memória
			addGameContext(GameContextFactory.MAIN_MENU);
			addGameContext(GameContextFactory.PAUSE_MENU);
			addGameContext(GameContextFactory.DEFEAT_GAME_MENU);
			addGameContext(GameContextFactory.VICTORY_GAME_MENU);

			
			// Adicionando estados
			addState(MAIN_MENU, function() { 
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
					switchContext(levelIndex, true, true); 
				}
				else {
					activeState = GAME_OVER;
				}
			});
			
			addState(START_GAME, function() { 
				addGameContext(levelIndex);
				switchContext(levelIndex); 
			});

			addState(RESTART_GAME, function() { 
				removeContext(levelIndex);
				activeState = START_GAME;
			});

			addState(BACK_TO_GAME, function() { 
				switchContext(levelIndex);
			});

			addState(GAME_OVER, function() {
				switchContext(GameContextFactory.MAIN_MENU);
				removeContext(levelIndex);
			});

			addState(DEFEAT_MATCH, function() { 
				switchContext(GameContextFactory.DEFEAT_GAME_MENU);
			});

			addState(VICTORY_MATCH, function() { 
				switchContext(GameContextFactory.VICTORY_GAME_MENU);
			});

			// Definindo contexto inicial
			switchContext(GameContextFactory.MAIN_MENU);
			// Luz, câmera, ação!
			runApp();
		}

		private function addGameContext(indexId:int):void {
			addContext(GameContextFactory.createContext(this, indexId), indexId);
		}
	
	}

}