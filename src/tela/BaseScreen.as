package tela 
{
	import flash.display.MovieClip;
	import evento.TelaEvent;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class BaseScreen extends MovieClip
	{
		//private var _stage:Stage;
		
		public function BaseScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			width = stage.stageWidth;
			height = stage.stageHeight;
		}
		
		protected function sair(status:int):void {
			dispatchEvent(new TelaEvent(TelaEvent.SAIDA_TELA, status));
		}

		protected function entrar(status:int):void {
			dispatchEvent(new TelaEvent(TelaEvent.ENTRADA_TELA, status));
		}

	}

}