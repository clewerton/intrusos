package src.app
{
	
	import flash.events.Event;
	import flash.ui.Keyboard;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	public class MainMenuContext extends GameContext
	{
			var menuVar:GameMenuItem;

			public function MainMenuContext(gameApp:GameApp)
			{
				super(gameApp);
				
				// Create inputManager:
				inputManager.addCommandMapping(Keyboard.E, "BEGIN_GAME");
				
				commandProcessor.addCommand("BEGIN_GAME", function() {
					gameApp.activeState = Main.START_GAME;
				});
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Teste", function() { commandProcessor.process("BEGIN_GAME"); });
			menuVar.x = width / 2;
			menuVar.y = height / 2;
			addChild(menuVar);
		}
			
	}
	
}
