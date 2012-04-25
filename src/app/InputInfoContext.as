package src.app {
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Tela de informação de input.
	 */
	
	public class InputInfoContext extends GameContext
	{
		
		public function InputInfoContext(gameApp:GameApp)
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
			menuVar.x = 400;
			menuVar.y = 550;
			addChild(menuVar);
		}
	}
	
}
