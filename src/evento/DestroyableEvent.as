package evento {

	import flash.events.Event;
	import entidade.GameObject;
	
	public class DestroyableEvent extends Event {

		//public const DESTROIED:String = "DestructableEvent:DESTROIED";
		
		private var _gameObject:GameObject;
		
		public function DestroyableEvent(type:String, obj:GameObject, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_gameObject = obj;
		}
		
		public function get gameObject():GameObject {
			return _gameObject;
		}
		
	}
}
