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

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameWorld extends Sprite {
		
		private var _stage:Stage;
		private var _towers:Vector.<Tower> = new Vector.<Tower>;
		private var _convoy:Convoy;
		private var _bullets:Vector.<Bullet> = new Vector.<Bullet>;

		private var _graph:DirectedGraph;
		
		// Para o jogo, 1 caminho só basta
		private var _path:Path;
		//private var _pathWalkers:Vector.<PathWalker> = new Vector.<PathWalker>();
		
		
		public function GameWorld(stageRef:Stage, graph:DirectedGraph, path:Path) {
			_stage = stageRef;
			_graph = graph;
			_path = path;
			//_graph.forEachEdge(handleClick);
			addChild(_graph);
		}

		public function addTower(tower:Tower):void {
			_towers.push(tower);
			addChild(tower);
		}

		public function removeTower(tower:Tower):void {
			_towers.splice(_towers.indexOf(tower), 1);
			removeChild(tower);
		}
		
		public function addVehicle(vehicle:Vehicle):void {
			_convoy.addVehicle(vehicle);
			addChild(vehicle);
		}

		public function removeVehicle(vehicle:Vehicle):void {
			_convoy.removeVehicle(vehicle);
			removeChild(vehicle);
		}
		
		public function addBullet(bullet:Bullet):void {
			_bullets.push(bullet);
			addChild(bullet);
		}
		
		public function removeBullet(bullet:Bullet):void {
			_bullets.splice(_bullets.indexOf(bullet), 1);
			removeChild(bullet);
		}

		public function update():void {
			checkColision();
			convoy.update();
			_path.update();
			/*for each(var pathWalker:PathWalker in _pathWalkers) {
				pathWalker.update();
			}*/
			for each(var tower:Tower in _towers) {
				tower.update();
			}
			for each(var bullet:Bullet in _bullets) {
				bullet.update();
			}
		}

		private function checkColision():void {
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
				addChild(vehicle);
			}
		}
		
		public function start():void {
			_path.start();
		}

		public function reset():void {
			_path.reset();
		}
		
		public function stop():void {
			_path.reset();
		}
		
		/*public function get path():Path {
			return _path;
		}
		
		public function set path(val:Path):void {
				_path = val;
		}*/
		
		/*public function get pathWalkers():Vector.<PathWalker> 
		{
			return _pathWalkers;
		}

		private function handleClick(item:Edge, index:int, vector:Vector.<Edge>):void {
			item.addEventListener(MouseEvent.CLICK, configurePath, false, 0, true);
		}*/
		
	}

}