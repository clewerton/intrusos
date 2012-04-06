package
{
	import engine.GameApp;
	import engine.GameContext;
	import evento.TelaEvent;
	import flash.events.Event;
	import level.GameContextFactory;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Main extends GameApp
	{
		// Estados do jogo
		public static const INIT_GAME = 1;
		public static const LEVEL_COMPLETE = 2;
		public static const GAME_OVER = 3;
		public static const PAUSE_GAME = 4;
		public static const GOTO_MENU = 5;

		// Contextos
		public static const FASE_1 = 1;
		public static const MAIN_MENU = 1000;
		
		public function Main():void
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initGame);
		}
		
		private function initGame(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Adicionando contextos
			addGameContext(MAIN_MENU);
			
			// Criando estados
			addState(INIT_GAME, 
				function() { 
					addGameContext(FASE_1); 
					switchContext(FASE_1) 
				} 
			);
			addState(LEVEL_COMPLETE, function() { switchContext(MAIN_MENU, true) } );
			addState(GAME_OVER, function() { switchContext(MAIN_MENU, true) } );
			addState(GOTO_MENU, function() { switchContext(MAIN_MENU) } );
			
			this.switchContext(MAIN_MENU);
			
			runApp();
		}
		
		private function addGameContext(indexId:uint):void {
			addContext(GameContextFactory.createContext(this, indexId), indexId);
		}
	
	}

}