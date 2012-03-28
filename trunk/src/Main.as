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
	import tela.TelaJogo;
	import terrain.Soil2;
	import tela.TelaInicial;
	import engine.GameScreen;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Main extends Sprite
	{

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
			
			var tela1:GameScreen = new TelaJogo();
			
			stage.addChild(tela1);
		}

	}

}