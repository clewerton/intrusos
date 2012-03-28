package entidade {
	
	import entidade.Tower;
	import entidade.Vehicle;
	import flash.display.Stage;
	import flash.events.Event;
	import entidade.Convoy;
	import grafo.DirectedGraph;
	import grafo.Path;
	import grafo.PathWalker;
	import grafo.Edge;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import engine.GameWorld;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class InstrusosWorld extends GameWorld {
		
		private var _towers:Vector.<Tower> = new Vector.<Tower>;
		private var _convoy:Convoy;
		private var _bullets:Vector.<Bullet> = new Vector.<Bullet>;

		private var _graph:DirectedGraph;
		
		// Para o jogo, 1 caminho só basta
		private var _path:Path;
		
		// Gerenciador de Input
		private var _inputManager:InputManager;
		
		public function InstrusosWorld(graph:DirectedGraph, path:Path) {
			_graph = graph;
			_path = path;
			_inputManager = new InputManager();
			_inputManager.addCommand(handleKeyboard.E, "START_WALKING");
			_inputManager.addCommand(handleKeyboard.R, "RESET_WALKING");
			_inputManager.addCommand(handleKeyboard.Q, "STOP_WALKING");
			
		}
		
				private function handleKeyboard(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case Keyboard.E: 
					if (_path.edges.length > 0) {
						_convoy.visible = true;
						EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
						world.startWalking();
					}
					break;
				case Keyboard.R:
					world.resetWalking();
					break;
				case Keyboard.Q:
					world.stopWalking();
					break;
			}
		}


		public override function init():void {
			super.init();
			addGameObject(_graph);
			addGameObject(_path);
		}
		
		public function addTower(tower:Tower):void {
			_towers.push(tower);
			addGameObject(tower);
		}

		public function removeTower(tower:Tower):void {
			_towers.splice(_towers.indexOf(tower), 1);
			removeGameObject(tower);
		}
		
		public function addVehicle(vehicle:Vehicle):void {
			_convoy.addVehicle(vehicle);
			addGameObject(vehicle);
		}

		public function removeVehicle(vehicle:Vehicle):void {
			_convoy.removeVehicle(vehicle);
			removeGameObject(vehicle);
		}
		
		public function addBullet(bullet:Bullet):void {
			_bullets.push(bullet);
			addGameObject(bullet);
		}
		
		public function removeBullet(bullet:Bullet):void {
			_bullets.splice(_bullets.indexOf(bullet), 1);
			removeGameObject(bullet);
		}

		protected override function checkColisions():void {
			for (var indexTowers:uint = 0; indexTowers < _towers.length; indexTowers++) {
				for (var indexVehicles:uint = 0; indexVehicles < convoy.vehicles.length; indexVehicles++) {
					if (convoy.vehicles[indexVehicles].range.hitTestObject(_towers[indexTowers].hitRegion) && convoy.vehicles[indexVehicles].enemy == null) {
						convoy.vehicles[indexVehicles].enemy = _towers[indexTowers];
					}
					if (_towers[indexTowers].range.hitTestObject(convoy.vehicles[indexVehicles].hitRegion) && _towers[indexTowers].enemy == null) {
						_towers[indexTowers].enemy = convoy.vehicles[indexVehicles];
					}
				}
			}
		}
		
		public function get convoy():Convoy {
			return _convoy;
		}
		
		public function set convoy(value:Convoy):void {
			_convoy = value;
			for each(var vehicle:Vehicle in _convoy.vehicles) {
				addGameObject(vehicle);
			}
		}
		
		public function startWalking():void {
			_path.startWalking();
		}

		public function resetWalking():void {
			_path.resetWalking();
		}
		
		public function stopWalking():void {
			_path.stopWalking();
		}
		
	}

}