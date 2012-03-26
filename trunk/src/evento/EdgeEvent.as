﻿package evento {
	
	import grafo.Edge;
	import flash.events.Event;
	
	public class EdgeEvent extends Event {

    //public static const EDGE_CLICKED:String = "EdgeEvent:EdgeClicked";

		private var _edge:Edge;
		
		public function EdgeEvent(type:String, theEdge:Edge, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_edge = theEdge;
		}

		public function get edge():Edge {
			return _edge;
		}

	}
	
}
