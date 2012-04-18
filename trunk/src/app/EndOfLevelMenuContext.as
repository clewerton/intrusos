package src.app
{
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	public class EndOfLevelMenuContext extends GameContext
	{

			public function EndOfLevelMenuContext(gameApp:GameApp)
			{
				super(gameApp);
				
				commandProcessor.addCommand("AGAIN", function() {
					gameApp.activeState = Main.RESTART_GAME;
				});
				commandProcessor.addCommand("GAME_OVER", function() {
					gameApp.activeState = Main.GAME_OVER;
				});
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			var menuVar:GameMenuItem;

			super.onAddedToStage(e);
			
			//if(

			menuVar = new GameMenuItem("Reinciar Partida", 0xFFFF00, function() { commandProcessor.process("AGAIN"); });

			menuVar = new GameMenuItem("Reiniciar Partida", 0xFFFF00, function() { commandProcessor.process("AGAIN"); });
			menuVar.x = 400;
			menuVar.y = 200;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Abortar Partida", 0xFFFF00, function() { commandProcessor.process("GAME_OVER"); });
			menuVar.x = 400;
			menuVar.y = 400;
			addChild(menuVar);

		}
			
	}
	
}
