﻿package lib.engine.event {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representa um evento de Estado.
	 */
	
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
