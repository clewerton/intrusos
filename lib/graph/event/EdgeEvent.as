package lib.graph.event {
	
	import flash.events.Event;
	import lib.graph.Edge;
	
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
