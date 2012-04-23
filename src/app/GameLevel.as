﻿package src.app
{
	import flash.ui.Keyboard;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.entidade.StandardTruck;
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
		public static const STARTING = 1;		// Começando o jogo
		public static const PLAYING = 2;		// jogando
		public static const PAUSED = 3;			// jogo em pausa
		public static const SUCCEDED = 4;		// jogo ganho
		public static const FAILED = 5;			// jogo perdido
		public static const CONFIG = 5;			// configurando a partida
		
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
			
			addState(PLAYING, function() { active = true; });
			addState(PAUSED, function() { active = false; });
			addState(SUCCEDED, function() {
				gameApp.activeState = Main.VICTORY_MATCH;
			});
			
			addState(FAILED, function() { 
				gameApp.activeState = Main.DEFEAT_MATCH;
			});
			
			inputManager.addCommandMapping(Keyboard.I, "INCLUDE_VEHICLE");
			inputManager.addCommandMapping(Keyboard.E, "START_WALKING");
			inputManager.addCommandMapping(Keyboard.P, "PAUSE_SCREEN");

			inputManager.addCommandMapping(Keyboard.W, "SCROLL_UP");
			inputManager.addCommandMapping(Keyboard.S, "SCROLL_DOWN");
			inputManager.addCommandMapping(Keyboard.A, "SCROLL_LEFT");
			inputManager.addCommandMapping(Keyboard.D, "SCROLL_RIGHT");

			commandProcessor.addCommand("START_WALKING", function() { _world.startWalkingPath(); });			
			commandProcessor.addCommand("INCLUDE_VEHICLE", function() {
				if(!_world.startedMoving()) {
					_world.addVehicle(new StandardTruck(_world)); 
				}
			});
			commandProcessor.addCommand("SCROLL_UP", function() { _world.scroll(0, -10); }, false);
			commandProcessor.addCommand("SCROLL_DOWN", function() { _world.scroll(0, 10); }, false);
			commandProcessor.addCommand("SCROLL_LEFT", function() { _world.scroll(-10, -0); }, false);
			commandProcessor.addCommand("SCROLL_RIGHT", function() { _world.scroll(10, 0); }, false);

			commandProcessor.addCommand("PAUSE_SCREEN", function() { 
				gameApp.activeState = Main.PAUSED; } 
			);
			
		}
		
		public override function enter():void {
			super.enter();
			_world.enter();
			activeState = STARTING;
		}
		
	}

}