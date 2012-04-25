package src.app
{
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Tela inicial (tela do menu).
	 */
	
	public class MainMenuContext extends GameContext
	{
		
		public function MainMenuContext(gameApp:GameApp)
		{
			super(gameApp);
		}
		
		protected override function onAddedToStage(e:Event = null):void
		{
			var menuVar:GameMenuItem;
			
			super.onAddedToStage(e);
			menuVar = new GameMenuItem("Iniciar fase 1", 0xFFFF00, function() {
					gameApp.levelIndex = 1;
					gameApp.activeState = Main.START_GAME;
			});
			menuVar.x = 400;
			menuVar.y = 250;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Iniciar fase 2", 0xFFFF00, function() {
					gameApp.levelIndex = 2;
					gameApp.activeState = Main.START_GAME;
			});
			menuVar.x = 400
			menuVar.y = 300;
			addChild(menuVar);
		
			menuVar = new GameMenuItem("Iniciar fase 3", 0xFFFF00, function() {
					gameApp.levelIndex = 3;
					gameApp.activeState = Main.START_GAME;
			});
			menuVar.x = 400
			menuVar.y = 350;
			addChild(menuVar);

			menuVar = new GameMenuItem("Como Jogar", 0xFFFF00, function() {
					gameApp.activeState = Main.INFO_PLAY;
			});
			menuVar.x = 400
			menuVar.y = 400;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Teclado e mouse", 0xFFFF00, function() {
					gameApp.activeState = Main.INFO_INPUT;
			});
			menuVar.x = 400
			menuVar.y = 450;
			addChild(menuVar);

			menuVar = new GameMenuItem("Selecao do caminho", 0xFFFF00, function() {
					gameApp.activeState = Main.INFO_PATH;
			});
			menuVar.x = 400
			menuVar.y = 500;
			addChild(menuVar);
		}
	
	}

}
