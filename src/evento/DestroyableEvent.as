package evento {

	import flash.events.Event;
	import entidade.GameObject;
	
	public class DestroyableEvent extends Event {

		//public const DESTROIED:String = "DestructableEvent:DESTROIED";
		
		private var _gameObject:GameObject;
		
		public function DestroyableEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public function get gameObject():GameObject {
			return _gameObject;
		}
		
		public function set gameObject(val:GameObject):void {
			_gameObject = val;
		}
	}
}
