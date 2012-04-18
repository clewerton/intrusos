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
				
				// Create inputManager:
				
				commandProcessor.addCommand("CONTINUE", function() {
					gameApp.activeState = Main.BACK_TO_GAME;
				});
				commandProcessor.addCommand("GAME_OVER", function() {
					gameApp.activeState = Main.GAME_OVER;
				});
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			var menuVar:GameMenuItem;

			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Continuar Jogo", function() { commandProcessor.process("CONTINUE"); });
			menuVar.x = 400;
			menuVar.y = 200;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Abortar partida", function() { commandProcessor.process("GAME_OVER"); });
			menuVar.x = 400;
			menuVar.y = 400;
			addChild(menuVar);

		}
			
	}
	
}
