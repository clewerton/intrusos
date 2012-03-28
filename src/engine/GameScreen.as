package engine 
{
	import engine.GameObject;
	import flash.display.MovieClip;
	import evento.TelaEvent;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameScreen extends GameObject
	{
		public override function init():void
		{
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