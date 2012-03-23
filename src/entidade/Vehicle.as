package entidade {
	import evento.DestroyableEvent;
	import evento.EventChannel;
	import flash.display.Shape;
	
	public class Vehicle extends GameObject {

		private var _radius:uint;
		private var _linearSpeed:uint;
		private var _angularSpeed:Number;
		private var _enemy:Tower;
		private var _states:Array;
		private var _range:Shape;

		public function Vehicle(health:uint, linearSpeed:uint, radius:uint) {
			super(health);
			_linearSpeed = linearSpeed;
			_radius = radius;
			
			_range = new Shape();
			_range.graphics.lineStyle(1, 0xAAAAAA, 0.4);
			_range.graphics.drawCircle(x, y, _radius);
			addChild(_range);
		}

		public function move():void {
			if (!active) {
				return;
			}
			
			rotation += _angularSpeed;
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
		
		public function update():void {
			if (!active || !_enemy) {
				return;
			}
			if (_range.hitTestObject(_enemy.hitRegion)) {
				_enemy.decreaseHealth(1);
				trace("Vehicle " + this.name + ":" + health);
				if(!_enemy.isAlive()) {
					_enemy = null;
				}
			} 
			else {
				_enemy = null;
			}
		}
		
	}
	
}
