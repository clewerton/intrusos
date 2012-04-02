package
{
	import engine.GameApp;
	import engine.GameContext;
	import evento.TelaEvent;
	import flash.events.Event;
	import context.GameWorld;
	import context.TelaInicial;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Main extends GameApp
	{

		public function Main():void
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initGame);
		}
		
		private function initGame(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			//var world:GameContext = new GameWorld(this, "HOSTILE");
			//var telaInicial:TelaInicial = new TelaInicial(this, "MENU");
			registerContext(GameWorld, "HOSTILE");
			registerContext(TelaInicial, "MENU");
			
			this.switchContext("MENU");

			runApp();
			
		}
		
	}

}