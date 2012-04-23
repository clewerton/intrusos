package src.entidade {
	
	import src.app.BaseWorld;
	import lib.utils.Utils;
	
	public class Bullet extends DestroyableObject {

		private var _speed:uint;
		private var _damage:int;
		private var _interval:uint;
		private var _enemy:DestroyableObject;
		
		public function Bullet(world:BaseWorld, health:uint, speed:uint, damage:uint) {
			super(world, health);
			_speed = speed;
			_enemy = enemy;
			_damage = damage;
		}
		
		public function get speed():uint {
			return _speed;
		}

		public function set speed(val: uint):void {
			_speed = val;
		}
		
		public function get enemy():DestroyableObject {
			return _enemy;
		}
		
		public function set enemy(value:DestroyableObject):void {
			_enemy = value;
		}
		
		public function get damage():int 
		{
			return _damage;
		}
		
		public function get interval():uint 
		{
			return _interval;
		}
		
		public function set interval(value:uint):void 
		{
			_interval = value;
		}
		
		public override function update():void {
			// Se o inimigo foi destruído no ciclo anterior, sua existência perdeu sentido...
			if ((enemy == null) || (!enemy.active)) {
				destroy();
				return;
			}
			var deltaX:int = _enemy.x - this.x;
			var deltaY:int = _enemy.y - this.y;

			var direction = Math.atan2(deltaY, deltaX);
			x += _speed * Math.cos(direction);
			y += _speed * Math.sin(direction);
			this.rotation = Utils.getDegree(direction);
			
			if (hitTestObject(_enemy.hitRegion)) {
				_enemy.decreaseHealth(_damage);
				trace("Enemy " + _enemy.name + ":" + _enemy.health);
				destroy();
			}
		}

	}
	
}
