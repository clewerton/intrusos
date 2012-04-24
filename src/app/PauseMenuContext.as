package src.app
{
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	public class PauseMenuContext extends GameContext
	{

			public function PauseMenuContext(gameApp:GameApp)
			{
				super(gameApp);
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			var menuVar:GameMenuItem;

			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Continuar Partida", 0xFFFF00, function() {
					gameApp.activeState = Main.BACK_TO_GAME;
			});
			menuVar.x = 400;
			menuVar.y = 250;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Abortar Partida", 0xFFFF00, function() { 
					gameApp.activeState = Main.GAME_OVER;
			});
			menuVar.x = 400;
			menuVar.y = 350;
			addChild(menuVar);

		}
			
	}
	
}
