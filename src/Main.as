package
{
	import entidade.*;
	import evento.*;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.ColorTransform;
	import flash.ui.Keyboard;
	import grafo.*;
	import EngineImpl;
	import terrain.Soil2;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Main extends Sprite
	{
		private var _engine:EngineImpl;

		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_engine = new EngineImpl(stage);
			_engine.start();
		}

	}

}