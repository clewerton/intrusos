package evento{
	import flash.events.Event;
	import grafo.Edge;

	/**
	 *
	 * Classe que representa os eventos de Path.
	 *
	 */

	public class PathEvent extends Event {

		//public static const PATH_FINISHED:String	= "PathEvent:PathFiished";
		//public static const EDGE_ADDED:String 		= "PathEvent:EdgeAdded";
		//public static const EDGE_REMOVED:String 		= "PathEvent:EdgeRemoved";
		//public static const EDGE_VISITED:String 	= "PathEvent:EdgeVisited";

		private var _edge:Edge;

		public function PathEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}

		public function get edge():Edge {
			return _edge;
		}

		public function set edge(theEdge:Edge):void {
			_edge = theEdge;
		}

	}
}