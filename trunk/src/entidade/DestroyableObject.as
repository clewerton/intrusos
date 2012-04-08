package src.entidade {
	
	import flash.display.Shape;
	import lib.engine.GameObject;
	import src.app.BaseWorld;
	import src.evento.EventChannel;
	import src.evento.DestroyableEvent;
	
	public class DestroyableObject extends GameObject {

		private var _world:BaseWorld;
		private var _health:int;
		protected var _hitRegion:Shape;
		private var _maxHealth;
		
		public function DestroyableObject(world:BaseWorld, health:int):void {
			_world = world;
			_health = health;
			_maxHealth = _health;
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
			if (_health < _maxHealth) {
				_health += valor;
			}
			notifyHealthChanged();
		}

		public function decreaseHealth(valor:int):void {
			if (!active || !isAlive()) {
				return;
			}
			_health -= valor;
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
		
	}
	
}
