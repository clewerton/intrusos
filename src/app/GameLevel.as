package src.app
{
	import flash.ui.Keyboard;
	import lib.engine.GameContext;
	import lib.engine.GameApp;
	import src.Main;
	import src.entidade.StandardTruck;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameLevel extends GameContext
	{
		// Índice do level
		private var _levelIndex:uint;
		
		// Layers
		private var _world:BaseWorld;
		
		// Estados possíveis do jogo
		public static const STARTING = 1;		// Começando o jogo
		public static const PLAYING = 2;		// jogando
		public static const PAUSED = 3;			// jogo em pausa
		public static const SUCCEDED = 4;		// jogo ganho
		public static const FAILED = 5;			// jogo perdido
		public static const LEAVING = 6;		// saindo da tela do jogo
		
		// O valor do último level
		protected const MAX_LEVEL:int = 1;
		
		public function GameLevel(gameApp:GameApp, levelIndex:uint = 1)
		{
			super(gameApp);
			_levelIndex = levelIndex;
			if (_levelIndex < 1) {
				_levelIndex = 1;
			}
			
			init();
			activeState = STARTING;
		}

		private function init():void {
			// Necessario pra pegar o escopo dentro de um closure
			var scope:GameLevel = this;
			
			addState(STARTING, function() {
				_world = GameWorldFactory.createWorld(scope, _levelIndex);
				addGameObject(_world);
			} );
			addState(PLAYING, function() { active = true; });
			addState(PAUSED, function() { active = false; });
			addState(SUCCEDED, function() {
				if(_levelIndex < MAX_LEVEL) {
					_levelIndex++; 
					activeState = STARTING;
				}
			});
			addState(FAILED, function() { activeState = STARTING; });
			addState(LEAVING, function() { gameApp.activeState = Main.MENU; } );
			
			inputManager.addCommandMapping(Keyboard.I, "INCLUDE_VEHICLE");
			inputManager.addCommandMapping(Keyboard.E, "START_WALKING");
			//inputManager.addCommandMapping(Keyboard.R, "RESET_WALKING");
			inputManager.addCommandMapping(Keyboard.Q, "STOP_WALKING");
			inputManager.addCommandMapping(Keyboard.V, "GO_MENU");
			inputManager.addCommandMapping(Keyboard.Z, "GAME_OVER");

			commandProcessor.addCommand("INCLUDE_VEHICLE", function() {
				if(!_world.convoyMoved()) {
					_world.addVehicle(new StandardTruck(_world)); 
				}
			});
			commandProcessor.addCommand("START_WALKING", function() { _world.startWalkingPath(); });
			//commandProcessor.addCommand("RESET_WALKING", function() {_world.resetWalkingPath(); });
			commandProcessor.addCommand("STOP_WALKING", function() {_world.stopWalkingPath(); });
			commandProcessor.addCommand("GO_MENU", function() { gameApp.activeState = Main.MENU; });
			commandProcessor.addCommand("GAME_OVER", function() { gameApp.activeState = Main.GAME_OVER; } );
		}
		
	}

}