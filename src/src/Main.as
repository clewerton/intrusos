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
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var world:GameContext = new GameWorld(this, "Hostile");
			var telaInicial:TelaInicial = new TelaInicial(this, "Menu");
			
			this.activeContext = "Hostile";

			runApp();
			
		}
		
	}

}