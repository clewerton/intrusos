package context
{
	import engine.GameApp;
	import engine.GameContext;
	import entidade.GameWorld;
	import evento.EventChannel;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GamePlayContext extends GameContext
	{
		// Layers
		private var _world:GameWorld;
		
		public function GamePlayContext(gameApp:GameApp)
		{
			super(gameApp);
			
			_world = new GameWorld();
			addGameObject(_world);
			
			// Create inputManager:
			inputManager.addCommandMapping(Keyboard.E, "START_WALKING");
			inputManager.addCommandMapping(Keyboard.R, "RESET_WALKING");
			inputManager.addCommandMapping(Keyboard.Q, "STOP_WALKING");
			inputManager.addCommandMapping(Keyboard.V, "GO_MENU");
			inputManager.addCommandMapping(Keyboard.Z, "GAME_OVER");

			commandProcessor.addCommand("START_WALKING", function() { _world.startWalkingPath();});
			commandProcessor.addCommand("RESET_WALKING", function() {_world.resetWalkingPath();});
			commandProcessor.addCommand("STOP_WALKING", function() {_world.stopWalkingPath();});
			commandProcessor.addCommand("GO_MENU", function() {gameApp.activeState = Main.GOTO_MENU;});
			commandProcessor.addCommand("GAME_OVER", function() {gameApp.activeState = Main.GAME_OVER;});
		}
		
		public override function update():void
		{
			super.update();
		}
		
		
		public override function dispose():void
		{
			super.dispose();
			_world = null;
		}
		
	}

}