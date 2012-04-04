package context
{
	
	import engine.GameApp;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import engine.GameMenuItem;
	import engine.GameContext;
	import flash.ui.Keyboard;
	import engine.CommandProcessor;
	
	public class MainMenuContext extends GameContext
	{
			var menuVar:GameMenuItem;

			public function MainMenuContext(gameApp:GameApp)
			{
				super(gameApp);
				
			// Create inputManager:
			inputManager.addCommandMapping(Keyboard.E, "BEGIN_GAME");
			
			commandProcessor.addCommand("BEGIN_GAME", function() {gameApp.activeState = Main.INIT_GAME;});
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Teste", action);
			width = stage.stageWidth / 2;
			x = stage.stageWidth / 4;
			height = stage.stageHeight / 2;
			y = stage.stageHeight / 4;
			//addChild(menuVar);
		}
			
			public function action(e:Event):void
			{
				trace("Botao clicado!!");
			}
	}
	
}
