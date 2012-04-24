package src.app
{
	import flash.ui.Keyboard;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import lib.engine.GameContextManager;
	import src.Main;
	
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
		
		// Estados possíveis do level
		public static const STARTING = 1;							// Começando o jogo
		public static const PLAYING = 2;							// jogando
		public static const PAUSED = 3;								// jogo em pausa
		public static const SUCCEDED = 4;							// jogo ganho
		public static const FAILED = 5;								// jogo perdido
		public static const CONVOY_CONFIG:int = 6;		// configurando o comboio	
		public static const GO_TO_MAP:int = 7;				// indo pra tela do jogo
		
		// O valor do último level
		public static const MAX_LEVEL:int = 2;
		
		private var _started:Boolean = false;
		
		public function GameLevel(gameApp:GameApp, levelIndex:uint = 1)
		{
			super(gameApp);
			
			_levelIndex = levelIndex;
			if (_levelIndex < 1) {
				_levelIndex = 1;
			}

			init();
			_world = GameWorldFactory.createWorld(this, _levelIndex);
			addGameObject(_world);
		}

		private function init():void {
			// Necessario pra pegar o escopo dentro de um closure
			var scope:GameLevel = this;
			
			addState(STARTING, function() {
				if(!_started) {
					_started = true;					 
					gameApp.activeState = Main.CONFIG_CONVOY;			
				}
				else {
					activeState = PLAYING;
				}
			});

			addState(CONVOY_CONFIG, function() {
				gameApp.activeState = Main.CONFIG_CONVOY;			
			});

			addState(GO_TO_MAP, function() {
				gameApp.activeState = Main.START_GAME; 
			});
			
			addState(PLAYING, function() { active = true; });
			addState(PAUSED, function() { active = false; } );
			
			addState(SUCCEDED, function() {
				gameApp.activeState = Main.VICTORY_MATCH;
			});
			
			addState(FAILED, function() { 
				gameApp.activeState = Main.DEFEAT_MATCH;
			});

			inputManager.addCommandMapping(Keyboard.E, "START_WALKING");
			inputManager.addCommandMapping(Keyboard.P, "PAUSE_SCREEN");

			inputManager.addCommandMapping(Keyboard.W, "SCROLL_UP");
			inputManager.addCommandMapping(Keyboard.S, "SCROLL_DOWN");
			inputManager.addCommandMapping(Keyboard.A, "SCROLL_LEFT");
			inputManager.addCommandMapping(Keyboard.D, "SCROLL_RIGHT");

			commandProcessor.addCommand("START_WALKING", function() { _world.startWalkingPath(); });			
			commandProcessor.addCommand("SCROLL_UP", function() { _world.scroll(0, -10); }, false);
			commandProcessor.addCommand("SCROLL_DOWN", function() { _world.scroll(0, 10); }, false);
			commandProcessor.addCommand("SCROLL_LEFT", function() { _world.scroll(-10, -0); }, false);
			commandProcessor.addCommand("SCROLL_RIGHT", function() { 
				_world.scroll(10, 0); 
			}, false);

			commandProcessor.addCommand("PAUSE_SCREEN", function() { 
				gameApp.activeState = Main.PAUSED; } 
			);
			
		}
		
		public override function enter():void {
			super.enter();
			_world.enter();
			if(activeState == 0) {
				activeState = STARTING;
			}
		}
		
		public function createConvoyFrom(config:Vector.<Class>):void {
			_world.createConvoyFrom(config);
		}
		
		
	}

}