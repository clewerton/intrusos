package src.app {
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import src.Main;
	import lib.engine.GameContext;
	
	
	public class PathInfoContext extends GameContext {
		
		public function PathInfoContext(gameApp:GameApp)
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
