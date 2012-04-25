package src.entidade {
	
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Classe base para torres.
	 */
	
	public class Tower extends DestroyableObject {

		private var _radius:uint;
		private var _enemy:Vehicle;
		private var _states:Array;
		private var _range:Shape;
		private var _timer:Timer;
		private var _canShoot:Boolean = false;

		public function Tower(world:BaseWorld, health:uint, radius:uint, bulletInterval:uint) {
			super(world, health, 0);
			_radius = radius;
			
			_range = new Shape();
			_range.graphics.lineStyle(1, 0xAAAAAA, 0);
			_range.graphics.drawCircle(x, y, _radius);
			addChild(_range);
			_timer = new Timer(bulletInterval);
			_timer.addEventListener(TimerEvent.TIMER, enableShooting, false, 0, true);
		}
		
		public function get radius():uint {
			return _radius;
		}
		
		public function set radius(valor:uint):void {
			_radius = valor;
		}
		
		public function get enemy():Vehicle {
			return _enemy;
		}
		
		public function set enemy(valor:Vehicle):void {
			_enemy = valor;
		}
		
		public function get range():Shape {
			return _range;
		}

		public override function update():void {
			if (!active || _enemy == null) {
				return;
			}
			if (_range.hitTestObject(_enemy.hitRegion)) {
				if(!_timer.running) {
					_timer.start();
				}
				if (_canShoot) {
					getNewBullet();
				}
				if(!_enemy.isAlive()) {
					_enemy = null;
				}
				_canShoot = false;
			}
			else {
				_timer.stop();
				_enemy = null;
			}
		}
		
		public function scoreValue():uint {
			throw Error("O metodo scoreValue da subclasse de Tower nao foi sobrescrito!");
		}
		
		private function enableShooting(e:TimerEvent):void {
			_canShoot = true;
		}
		
		protected function getNewBullet():void {
			throw new Error("Metodo Abstrato!");
		}
		
		public function dispose():void {
			_range = null;
			_timer = null;
		}
		
	}
	
}
