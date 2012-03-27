package tela 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Humberto Anjos
	 */
	public class TelaJogo extends BaseScreen
	{
		private var _engine:EngineImpl;
		
		protected override function init(e:Event = null):void
		{
			super.init(e);
			_engine = new EngineImpl(stage);
			_engine.start();
		}
		
	}

}