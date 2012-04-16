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
				inputManager.addCommandMapping(Keyboard.NUMBER_1, "LEVEL_1");
				inputManager.addCommandMapping(Keyboard.NUMBER_2, "LEVEL_2");
				
				commandProcessor.addCommand("LEVEL_1", function() {
					gameApp.activeState = Main.START_GAME;
				});
				commandProcessor.addCommand("LEVEL_2", function() {
					gameApp.activeState = Main.NEXT_LEVEL;
				});
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Iniciar fase 1", function() { commandProcessor.process("LEVEL_1"); });
			menuVar.x = width / 2;
			menuVar.y = height / 2;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Iniciar fase 2", function() { trace("Nojento! Tcham!!") });
			menuVar.x = width / 2;
			menuVar.y = height * 2 / 3;
			addChild(menuVar);

		}
			
	}
	
}
