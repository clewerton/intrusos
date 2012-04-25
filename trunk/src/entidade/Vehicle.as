package src.entidade {
	
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import src.app.BaseWorld;

		/**
	 * ...
	 * @author Clewerton Coelho
	 * Classe base para veículos.
	 */

	public class Vehicle extends DestroyableObject {

		private var _linearSpeed:uint;
		private var _angularSpeed:Number;
		private var _enemy:Tower;
		private var _states:Array;
		private var _range:Shape;
		private var _cannon:Cannon;
		
		private var _index:int;

		public function Vehicle(world:BaseWorld, health:uint, linearSpeed:uint, endurance:uint, cannon:Cannon) {
			super(world, health, endurance);
			_linearSpeed = linearSpeed;
			_cannon = cannon;
			_range = new Shape();
			_range.graphics.lineStyle(1, 0xAAAAAA, 0);
			_range.graphics.drawCircle(x, y, cannon.radius);
			addChild(_range);
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
		
		public override function update():void {
			super.update();
			if (!active || _enemy == null) {
				return;
			}
			if (_range.hitTestObject(_enemy.hitRegion)) {
				_cannon.shoot();
				if(!_enemy.isAlive()) {
					_enemy = null;
				}
			} 
			else {
				_cannon.deactivate();
				_enemy = null;
			}
		}
		
		public function dispose():void {
			_range = null;
			_cannon = null;
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
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
		public function get cannon():Cannon 
		{
			return _cannon;
		}
		
		public function set cannon(value:Cannon):void 
		{
			_cannon = value;
		}
		
	}
	
}
