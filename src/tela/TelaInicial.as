package tela
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import engine.GameScreen;
	import engine.GameMenuItem;
	
	public class TelaInicial extends GameScreen
	{
			var menuVar:GameMenuItem;
	
			public override function init():void
			{
				super.init();
				menuVar = new GameMenuItem("Teste", action);
				//addChild(menuVar);
			}
			
			public function action(e:Event):void
			{
				trace("Botao clicado!!");
			}
	}
	
}
