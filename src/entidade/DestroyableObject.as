package entidade {
	
	import engine.GameObject;
	import evento.DestroyableEvent;
	import evento.EventChannel;
	import flash.display.Shape;
	
	public class DestroyableObject extends GameObject {

		private var _world:BaseWorld;
		private var _health:int;
		protected var _hitRegion:Shape;
		
		public function DestroyableObject(world:BaseWorld, health:int):void {
			_world = world;
			_health = health;
			_hitRegion = new Shape();
			addChild(_hitRegion);
		}

		public function destroy():void {
			_health = 0;
			notifyDestroy();
		}
		
		public function decreaseHealth(valor:int):void {
			if (!active || !isAlive()) {
				return;
			}
			_health -= valor;
			if (isAlive()) {
				notifyHit();
			}
			else {
				notifyDestroy();
			}
		}

		public function notifyHit():void {
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
