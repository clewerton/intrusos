package entidade {
	
	import entidade.Tower;
	import entidade.Vehicle;
	import flash.display.Stage;
	import flash.events.Event;
	import grafo.Map;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameWorld {
		
		private var _stage:Stage;
		private var _map:Map;
		private var _towers:Vector.<Tower> = new Vector.<Tower>;
		private var _vehicles:Vector.<Vehicle> = new Vector.<Vehicle>;
		private var _bullets:Vector.<Bullet> = new Vector.<Bullet>;
		//private var _inputManager:InputManager;
		//private var _soundManager:SoundManager;
		
		public function GameWorld(stageRef:Stage, map:Map) {
			_stage = stageRef;
			_map = map;
		}

		public function start():void {
			_stage.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}

		public function stop():void {
			_stage.removeEventListener(Event.ENTER_FRAME, update, false);
		}

		public function addTower(tower:Tower):void {
			_towers.push(tower);
			_map.addChild(tower);
		}

		public function removeTower(tower:Tower):void {
			_towers.splice(_towers.indexOf(tower), 1);
			_map.removeChild(tower);
		}
		
		public function addVehicle(vehicle:Vehicle):void {
			_vehicles.push(vehicle);
			_map.addChild(vehicle);
		}

		public function removeVehicle(vehicle:Vehicle):void {
			_vehicles.splice(_vehicles.indexOf(vehicle), 1);
			_map.removeChild(vehicle);
		}
		
		public function addBullet(bullet:Bullet):void {
			_bullets.push(bullet);
		}
		
		public function removeBullet(bullet:Bullet):void {
			_bullets.splice(_bullets.indexOf(bullet), 1);
			_bullets.push(bullet);
		}

		public function update(e:Event):void {
			checkColision();
			for each(var tower:Tower in _towers) {
				tower.update();
			}
			for each(var vehicle:Vehicle in _vehicles) {
				vehicle.update();
			}
		}
		
		private function checkColision():void {
			for (var indexTowers:uint = 0; indexTowers < _towers.length; indexTowers++) {
				for (var indexVehicles:uint = 0; indexVehicles < _vehicles.length; indexVehicles++) {
					if (_vehicles[indexVehicles].range.hitTestObject(_towers[indexTowers].hitRegion) && _vehicles[indexVehicles].enemy == null) {
						_vehicles[indexVehicles].enemy = _towers[indexTowers];
					}
					if (_towers[indexTowers].range.hitTestObject(_vehicles[indexVehicles].hitRegion) && _towers[indexTowers].enemy == null) {
						_towers[indexTowers].enemy = _vehicles[indexVehicles];
					}
				}
			}
		}
		
	}

}