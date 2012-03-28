package entidade {
	import engine.GameObject;
	import flash.display.Shape;
	import evento.DestroyableEvent;
	import evento.EventChannel;
	import flash.events.Event;
	
	public class DestroyableObject extends GameObject {

		private var _engine:EngineImpl;
		private var _health:int;
		protected var _hitRegion:Shape;
		private var _active:Boolean = true;
		
		public function DestroyableObject(health:int):void {
			_engine = engine;
			_health = health;
			_hitRegion = new Shape();
		}

		public override function init():void
		{
			addChild(_hitRegion);
		}
		
		public override function update():void 
		{			
		}
		
		public override function dispose():void 
		{			
		}
		
		public function destroy():void {
			_health = 0;
			notifyDestroy();
		}
		
		public function decreaseHealth(valor:int):void {
			if (!_active || !isAlive()) {
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
		
		public function get active():Boolean {
			return _active;
		}

		public function set active(val:Boolean):void {
			_active = val;
		}
		
		public function get engine():EngineImpl {
			return _engine;
		}
		
		public function set engine(value:EngineImpl):void {
			_engine = value;
		}
		
	}
	
}
