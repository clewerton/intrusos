package src
{
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.app.ConvoyConfigContext;
	import src.app.GameContextFactory;
	import src.app.GameLevel;
	import flash.display.StageScaleMode;
	import src.evento.ConvoySelectedEvent;
	import src.evento.EventChannel;
	
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
		public static const CONFIG_CONVOY:int = 11;		// configurando o comboio
		public static const BACK_TO_MENU:int = 12;		// de volta ao menu
		public static const INFO_INPUT:int = 13;			// mostrando informações sobre comandos e teclas
		public static const INFO_PATH:int = 14;				// mostrando informações sobre como configurar o caminho
		public static const INFO_PLAY:int = 15;				// mostrando informações sobre como jogar

		private var _convoyConfigContext:GameContext;
		private var _currentLevelContext:GameContext;
		
		public function Main():void
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener(Event.ADDED_TO_STAGE, initGame);
		}
		
		private function initGame(e:Event = null):void
		{
			// Necessario pra pegar o escopo dentro de um closure
			var scope:GameApp = this;
			
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

			addState(BACK_TO_MENU, function() { 
				switchContext(GameContextFactory.MAIN_MENU, true, true); 
			});

			addState(INFO_INPUT, function() { 
				addGameContext(GameContextFactory.INFO_INPUT);
				switchContext(GameContextFactory.INFO_INPUT);
			});

			addState(INFO_PATH, function() { 
				addGameContext(GameContextFactory.INFO_PATH);
				switchContext(GameContextFactory.INFO_PATH);
			});

			addState(INFO_PLAY, function() { 
				addGameContext(GameContextFactory.INFO_PLAY);
				switchContext(GameContextFactory.INFO_PLAY);
			});
			
			addState(PAUSED, function() { 
				switchContext(GameContextFactory.PAUSE_MENU, false); 
			});

			addState(CONFIG_CONVOY, function() {
				_convoyConfigContext = GameContextFactory.createContext(scope, GameContextFactory.CONVOY_CONFIG);
				_convoyConfigContext.addEventListener(EventChannel.CONVOY_SELECTED, createConvoy, false, 0, true);
				addContext(_convoyConfigContext, GameContextFactory.CONVOY_CONFIG);
				switchContext(GameContextFactory.CONVOY_CONFIG);
			});
			
			addState(START_CAMPAIGN, function() { 
				levelIndex = 1;
				addGameLevel(levelIndex);
				switchContext(levelIndex); 
			});

			addState(NEXT_LEVEL, function() {
				if (levelIndex < GameLevel.MAX_LEVEL) {
					removeGameLevel(levelIndex);
					levelIndex++;
					addGameLevel(levelIndex);
					switchContext(levelIndex);
				}
				else {
					activeState = GAME_OVER;
				}
			});
			
			addState(START_GAME, function() { 
				addGameLevel(levelIndex);
				switchContext(levelIndex); 
			});

			addState(RESTART_GAME, function() { 
				removeGameLevel(levelIndex);
				activeState = START_GAME;
			});

			addState(BACK_TO_GAME, function() {
				switchContext(levelIndex);
			});

			addState(GAME_OVER, function() {
				switchContext(GameContextFactory.MAIN_MENU);
				removeGameLevel(levelIndex);
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

		private function addGameLevel(indexId:int):void {
			_currentLevelContext = GameContextFactory.createContext(this, indexId);
			addContext(_currentLevelContext, indexId);
		}

		private function removeGameLevel(indexId:int):void {
			removeContext(indexId);
			removeContext(GameContextFactory.CONVOY_CONFIG);
			_currentLevelContext = null;
		}

		private function createConvoy(ev:ConvoySelectedEvent):void {
			(_currentLevelContext as GameLevel).createConvoyFrom(ev.selection);
		}
		
	}

}