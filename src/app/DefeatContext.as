package src.app
{
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	public class DefeatContext extends GameContext
	{

			public function DefeatContext(parentContext:GameContext)
			{
				super(parentContext);
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			var menuVar:GameMenuItem;

			super.onAddedToStage(e);
			
			menuVar = new GameMenuItem("Reiniciar Partida", 0xFFFF00, function() { 
				parentContext.activeState = Main.RESTART_GAME;
			});
			menuVar.x = 400;
			menuVar.y = 400;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Abortar Partida", 0xFFFF00, function() { 
				parentContext.activeState = Main.GAME_OVER;
			});
			menuVar.x = 400;
			menuVar.y = 450;
			addChild(menuVar);

		}
			
	}
	
}
