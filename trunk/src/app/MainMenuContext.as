package src.app
{
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	public class MainMenuContext extends GameContext
	{
		
		public function MainMenuContext(parentContext:GameContext)
		{
			super(parentContext);
		}
		
		protected override function onAddedToStage(e:Event = null):void
		{
			var gameApp:GameApp = parentContext as GameApp;
			var menuVar:GameMenuItem;
			
			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Iniciar fase 1", 0xFFFF00, function() {
					gameApp.levelIndex = 1;
					gameApp.activeState = Main.START_GAME;
			});
			menuVar.x = 400;
			menuVar.y = 350;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Iniciar fase 2", 0xFFFF00, function() {
					gameApp.levelIndex = 2;
					gameApp.activeState = Main.START_GAME;
			});
			menuVar.x = 400
			menuVar.y = 400;
			addChild(menuVar);
		
		}
	
	}

}
