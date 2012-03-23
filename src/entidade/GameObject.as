package entidade {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import evento.DestroyableEvent;
	import evento.EventChannel;
	import flash.display.Shape;
	
	public class GameObject extends MovieClip {

		private var _health:int;
		protected var _hitRegion:Shape;
		private var _active:Boolean = true;
		
		public function GameObject(health:int):void {
			_health = health;
			_hitRegion = new Shape();
			addChild(_hitRegion);
		}

		public function decreaseHealth(valor:int):void {
			if(!_active || !isAlive()) {
				return;
			}
			
			_health -= valor;
			//trace(_health);
			
			if (isAlive()) {
				notifyHit();
			}
			else {
				notifyDestroy();
			}
		}

		public function notifyHit():void {
			var ev:DestroyableEvent = new DestroyableEvent(EventChannel.OBJECT_HIT);
			ev.gameObject = this;
			dispatchEvent(ev);
		}

		protected function notifyDestroy():void {
			var ev:DestroyableEvent = new DestroyableEvent(EventChannel.OBJECT_DESTROYED);
			ev.gameObject = this;
			dispatchEvent(ev);
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
		
		public function get active():Boolean {
			return _active;
		}

		public function set active(val:Boolean):void {
			_active = val;
		}
		
	}
	
}
