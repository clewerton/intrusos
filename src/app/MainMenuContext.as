package src.app
{
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	public class MainMenuContext extends GameContext
	{

			public function MainMenuContext(gameApp:GameApp)
			{
				super(gameApp);
				
				// Create inputManager:
				
				commandProcessor.addCommand("LEVEL_1", function() {
					gameApp.levelIndex = 1;
					gameApp.activeState = Main.START_GAME;
				});
				commandProcessor.addCommand("LEVEL_2", function() {
					gameApp.levelIndex = 2;
					gameApp.activeState = Main.START_GAME;
				});
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			var menuVar:GameMenuItem;

			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Iniciar fase 1", function() { commandProcessor.process("LEVEL_1"); });
			menuVar.x = width / 2;
			menuVar.y = height / 3;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Iniciar fase 2", function() { commandProcessor.process("LEVEL_2"); });
			menuVar.x = width / 2;
			menuVar.y = height * 2 / 3;
			addChild(menuVar);

		}
			
	}
	
}
