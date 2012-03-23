package entidade {
	
	public class Bullet extends GameObject {

		private var _speed:uint;
		private var _enemy:GameObject;
		
		public function Bullet(enemy:GameObject, health:uint, speed:uint) {
			super(health);
			_speed = speed;
			_enemy = enemy;
		}
		
		public function get speed():uint {
			return _speed;
		}

		public function set speed(val: uint):void {
			_speed = val;
		}

	}
	
}
