package evento {
	
	import grafo.Edge;
	import flash.events.Event;
	
	public class StateEvent extends Event {

		private var _state:uint;
		
		public function StateEvent(type:String, state:uint, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_state = state;
		}

		public function get state():uint {
			return _state;
		}

	}
	
}
