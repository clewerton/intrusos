package src.app {
	
	import flash.display.MovieClip;
	import lib.engine.GameContext;
	import flash.events.Event;
	import src.Main;
	import lib.engine.GameApp;
	
	
	public class GamePlayInfoContext extends GameContext {
		
		
		public function GamePlayInfoContext(gameApp:GameApp)
		{
			super(gameApp);
		}

		protected override function onAddedToStage(e:Event = null):void
		{
			var menuVar:GameMenuItem;
			
			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Voltar", 0xFFFF00, function() {
					gameApp.activeState = Main.BACK_TO_MENU;
			});
			menuVar.x = 600;
			menuVar.y = 550;
			addChild(menuVar);
		}
	}
	
}
