package context
{
	import engine.GameApp;
	import engine.GameContext;
	import evento.EventChannel;
	import flash.ui.Keyboard;
	import entidade.BaseWorld;
	import level.level1.World1;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GamePlayContext extends GameContext
	{
		// Layers
		private var _world:BaseWorld;
		
		public function GamePlayContext(gameApp:GameApp)
		{
			super(gameApp);
			
			_world = new World1(gameApp);
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
			commandProcessor.addCommand("GAME_OVER", function() { gameApp.activeState = Main.GAME_OVER; } );
			
		}
		
		public override function update():void
		{
			super.update();
		}
		
	}

}