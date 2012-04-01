package context
{
	
	import engine.GameApp;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import engine.GameMenuItem;
	import engine.GameContext;
	
	public class TelaInicial extends GameContext
	{
			var menuVar:GameMenuItem;

			public function TelaInicial(gameApp:GameApp, id:String)
			{
				super(gameApp, id);
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Teste", action);
			width = stage.stageWidth;
			height = stage.stageHeight;
			//addChild(menuVar);
		}
			
			public function action(e:Event):void
			{
				trace("Botao clicado!!");
			}
	}
	
}
