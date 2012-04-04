package
{
	import context.MainMenuContext;
	import engine.GameApp;
	import engine.GameContext;
	import evento.TelaEvent;
	import flash.events.Event;
	import context.GamePlayContext;
	
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
		
		public function Main():void
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initGame);
		}
		
		private function initGame(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Registrando contextos
			registerContext(GamePlayContext, "HOSTILE");
			registerContext(MainMenuContext, "MENU");
			
			// Criando estados
			addState(INIT_GAME, function() { switchContext("HOSTILE") } );
			addState(LEVEL_COMPLETE, function() { switchContext("MENU") } );
			addState(GAME_OVER, function() { switchContext("MENU", true) } );
			addState(GOTO_MENU, function() { switchContext("MENU") } );
			
			this.switchContext("MENU");
			
			runApp();
		}
	
	}

}