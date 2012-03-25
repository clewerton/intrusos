package entidade {
	
	import entidade.Tower;
	import entidade.Vehicle;
	import flash.display.Stage;
	import flash.events.Event;
	import grafo.Map;
	import entidade.Convoy;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameWorld {
		
		private var _stage:Stage;
		private var _map:Map;
		private var _towers:Vector.<Tower> = new Vector.<Tower>;
		private var _convoy:Convoy;
		private var _bullets:Vector.<Bullet> = new Vector.<Bullet>;
		
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
			_convoy.addVehicle(vehicle);
			_map.addChild(vehicle);
		}

		public function removeVehicle(vehicle:Vehicle):void {
			_convoy.removeVehicle(vehicle);
			_map.removeChild(vehicle);
		}
		
		public function addBullet(bullet:Bullet):void {
			_bullets.push(bullet);
			_map.addChild(bullet);
		}
		
		public function removeBullet(bullet:Bullet):void {
			_bullets.splice(_bullets.indexOf(bullet), 1);
			_map.removeChild(bullet);
		}

		public function update(e:Event):void {
			checkColision();
			convoy.update();
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
				_map.addChild(vehicle);
			}
		}
		
	}

}