package src.app
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import lib.engine.GameContext;
	import lib.engine.GameApp;
	import src.Main;
	
	public class MainMenuContext extends GameContext
	{
			var menuVar:GameMenuItem;

			public function MainMenuContext(gameApp:GameApp)
			{
				super(gameApp);
				
			// Create inputManager:
			inputManager.addCommandMapping(Keyboard.E, "BEGIN_GAME");
			
			commandProcessor.addCommand("BEGIN_GAME", function() {gameApp.activeState = Main.GAME_PLAY;});
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Teste", action);
			width = stage.stageWidth;
			height = stage.stageHeight;
			//addChild(menuVar);
		}
			
			public function action(e:Event):void
			{
				trace("Botao clicado!!");
			}
	}
	
}
