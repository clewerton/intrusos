package src.entidade {
	
	import flash.display.Shape;
	import lib.engine.GameObject;
	import src.app.BaseWorld;
	import src.evento.DestroyableEvent;
	import src.evento.EventChannel;
	
	public class DestroyableObject extends GameObject {

		private var _world:BaseWorld;
		private var _health:int;
		protected var _hitRegion:Shape;
		private var _maxHealth;
		private var _endurance:uint;

		
		public function DestroyableObject(world:BaseWorld, maxHealth:int, endurance:uint):void {
			_world = world;
			_maxHealth = maxHealth;
			_health = _maxHealth;
			_endurance = endurance;
			_hitRegion = new Shape();
			addChild(_hitRegion);
		}

		public function destroy():void {
			_health = 0;
			notifyDestroy();
		}
		
		public function increaseHealth(valor:int):void {
			if (!active || !isAlive()) {
				return;
			}
			_health += valor;
			if (_health > _maxHealth) {
				_health = _maxHealth;
			}
			notifyHealthChanged();
		}

		public function decreaseHealth(valor:int):void {
			if (!active || !isAlive()) {
				return;
			}
			_health -= (valor - _endurance);
			if (isAlive()) {
				notifyHealthChanged();
			}
			else {
				notifyDestroy();
			}
		}

		public function notifyHealthChanged():void {
			dispatchEvent(new DestroyableEvent(EventChannel.OBJECT_HIT, this));
		}

		protected function notifyDestroy():void {
			dispatchEvent(new DestroyableEvent(EventChannel.OBJECT_DESTROYED, this));
		}
		
		public function isAlive():Boolean {
			return _health > 0;
		}
		
		public function get health():int {
			return _health;
		}

		public function get hitRegion():Shape {
				return _hitRegion;
		}
		
		public function get gameWorld():BaseWorld
		{
			return _world;
		}
		
		public function get endurance():uint 
		{
			return _endurance;
		}
		
		public function set endurance(value:uint):void 
		{
			_endurance = value;
		}
		
	}
	
}
