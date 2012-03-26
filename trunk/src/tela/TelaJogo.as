package tela 
{
	import tela.TelaBase;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Humberto Anjos
	 */
	public class TelaJogo extends TelaBase 
	{
		private var _engine:EngineImpl;
		
		public function TelaJogo() 
		{
		}

		protected override function init(e:Event = null):void
		{
			_engine = new EngineImpl(stage);
			_engine.start();
		}
		
	}

}