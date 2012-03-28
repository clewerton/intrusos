package tela 
{
	import flash.events.Event;
	import engine.GameScreen;
	
	/**
	 * ...
	 * @author Humberto Anjos
	 */
	public class TelaJogo extends GameScreen
	{
		private var _engine:EngineImpl;
		
		public override function init():void
		{
			super.init();
			_engine = new EngineImpl();
			addChild(_engine);
			_engine.runApp();
		}
		
	}

}