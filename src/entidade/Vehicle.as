package entidade {
	
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Vehicle extends DestroyableObject {

		private var _radius:uint;
		private var _linearSpeed:uint;
		private var _angularSpeed:Number;
		private var _enemy:Tower;
		private var _states:Array;
		private var _range:Shape;
		private var _timer:Timer;
		private var _canShoot:Boolean = false;

		public function Vehicle(world:BaseWorld, health:uint, linearSpeed:uint, radius:uint) {
			super(world, health);
			_linearSpeed = linearSpeed;
			_radius = radius;
			_range = new Shape();
			_range.graphics.lineStyle(1, 0xAAAAAA, 0.4);
			_range.graphics.drawCircle(x, y, _radius);
			addChild(_range);
			
			_timer = new Timer(300);
			_timer.addEventListener(TimerEvent.TIMER, enableShooting, false, 0, true);
		}

		public function move():void {
			if (!active) {
				return;
			}
			
			rotation += _angularSpeed;
			rotation %= (Math.PI * 2);
			x += (_linearSpeed * Math.cos(rotation));
			y += (_linearSpeed * Math.sin(rotation));
		}
		
		public function get speed():uint {
			return _linearSpeed;
		}
		
		public function set speed(val:uint):void {
			_linearSpeed = val;
		}

		public function set angularSpeed(val:Number):void {
			_angularSpeed = val;
		}
		
		public function get angularSpeed():Number { 
			return _angularSpeed; 
		} 
		
		public function get enemy():Tower {
			return _enemy;
		}
		
		public function set enemy(valor:Tower):void {
			_enemy = valor;
		}
		
		public function get range():Shape {
			return _range;
		}
		
		public override function update():void {
			super.update();
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
				_enemy = null;
			}
		}
		
		private function enableShooting(e:TimerEvent):void {
			_canShoot = true;
		}
		
		protected function getNewBullet():void {
			throw new Error("Metodo Abstrato!");
		}
		
		
	}
	
}
